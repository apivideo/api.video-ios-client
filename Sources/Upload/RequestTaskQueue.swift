import Foundation

public class RequestTaskQueue<T>: RequestTask {
    private let operationQueue: OperationQueue
    private var requestBuilders: [RequestBuilder<T>] = []

    private let _progress = Progress(totalUnitCount: 0)

    internal init(queueLabel: String) {
        operationQueue = OperationQueue()
        operationQueue.name = "video.api.RequestQueue.\(queueLabel)"
        operationQueue.maxConcurrentOperationCount = 1
        super.init()
    }

    @available(iOS 11.0, macOS 10.13, macCatalyst 13.0, tvOS 11.0, watchOS 4.0, *)
    override public var progress: Progress {
        var completedUnitCount: Int64 = 0
        var totalUnitCount: Int64 = 0
        requestBuilders.forEach {
            if let progress = $0.requestTask.progress {
                completedUnitCount += progress.completedUnitCount
                totalUnitCount += progress.totalUnitCount
            }
        }

        _progress.totalUnitCount = totalUnitCount
        _progress.completedUnitCount = completedUnitCount
        return _progress
    }

    internal func willExecuteRequestBuilder(requestBuilder: RequestBuilder<T>) -> Void {
    }

    internal func execute(_ requestBuilder: RequestBuilder<T>,
                          apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue,
                          completion: @escaping (_ data: T?, _ error: Error?) -> Void) -> Void {
        requestBuilders.append(requestBuilder)
        return operationQueue.addOperation(RequestOperation(requestBuilder: requestBuilder, apiResponseQueue: apiResponseQueue, willExecuteRequestBuilder: willExecuteRequestBuilder, completion: completion))
    }
    

    override public func cancel() {
        requestBuilders.forEach {
            $0.requestTask.cancel()
        }
        operationQueue.cancelAllOperations()
    }

    override public var isFinished: Bool {
        requestBuilders.allSatisfy { $0.requestTask.isFinished }
    }
}

final class RequestOperation<T>: Operation {
    private let requestBuilder: RequestBuilder<T>
    private let apiResponseQueue: DispatchQueue
    private let completion: (_ data: T?, _ error: Error?) -> Void
    private let willExecuteRequestBuilder: (_: RequestBuilder<T>) -> Void
    private let group = DispatchGroup()

    init(requestBuilder: RequestBuilder<T>, apiResponseQueue: DispatchQueue, willExecuteRequestBuilder: @escaping (_: RequestBuilder<T>) -> Void, completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
        self.requestBuilder = requestBuilder
        self.apiResponseQueue = apiResponseQueue
        self.willExecuteRequestBuilder = willExecuteRequestBuilder
        self.completion = completion
        super.init()
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        group.enter()

        self.willExecuteRequestBuilder(requestBuilder)
        requestBuilder.execute(apiResponseQueue) { result in
            switch result {
            case let .success(response):
                self.completion(response.body, nil)
            case let .failure(error):
                self.completion(nil, error)
            }
            self.group.leave()
        }
        // Make task synchronous
        group.wait()
    }
}
