import Foundation

public class UploadChunkRequestTaskQueue: RequestTaskQueue<Video> {
    private let requestBuilders: [RequestBuilder<Video>]

    private let onProgressReady: ((Progress) -> Void)?
    private let apiResponseQueue: DispatchQueue
    private let completion: (_ data: Video?, _ error: Error?) -> Void

    private var videoId: String?
    private let _progress: Progress

    private var hasSentError = false

    internal init(requestBuilders: [RequestBuilder<Video>],
                  fileSize: Int64,
                  queueLabel: String,
                  onProgressReady: ((Progress) -> Void)? = nil,
                  apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue,
                  completion: @escaping (_ data: Video?, _ error: Error?) -> Void) {
        _progress = Progress(totalUnitCount: fileSize)
        self.requestBuilders = requestBuilders
        self.onProgressReady = onProgressReady
        self.apiResponseQueue = apiResponseQueue
        self.completion = completion
        super.init(queueLabel: queueLabel)

        requestBuilders.forEach { requestBuilder in
            execute(requestBuilder,
                    apiResponseQueue: apiResponseQueue,
                    completion: completionHook)
        }
    }

    internal convenience init(videoId: String,
                              file: URL,
                              onProgressReady: ((Progress) -> Void)? = nil,
                              apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue,
                              completion: @escaping (_ data: Video?, _ error: Error?) -> Void) throws {
        let chunkInputStreams = try FileChunkInputStreamsBuilder(file: file).build()
        let numOfChunks = chunkInputStreams.count

        var requestBuilders: [RequestBuilder<Video>] = []
        chunkInputStreams.enumerated().forEach { chunkId, chunkInputStream in
            let requestBuilder = VideosAPI.uploadWithRequestBuilder(videoId: videoId, file: chunkInputStream, chunkId: chunkId + 1, numOfChunks: numOfChunks, onProgressReady: nil)
            requestBuilders.append(requestBuilder)
        }
        try self.init(requestBuilders: requestBuilders, fileSize: file.fileSize, queueLabel: videoId, onProgressReady: onProgressReady, apiResponseQueue: apiResponseQueue, completion: completion)
        self.videoId = videoId
    }

    internal convenience init(token: String,
                              file: URL,
                              videoId: String? = nil,
                              onProgressReady: ((Progress) -> Void)? = nil,
                              apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue,
                              completion: @escaping (_ data: Video?, _ error: Error?) -> Void) throws {
        let chunkInputStreams = try FileChunkInputStreamsBuilder(file: file).build()
        let numOfChunks = chunkInputStreams.count

        var requestBuilders: [RequestBuilder<Video>] = []
        chunkInputStreams.enumerated().forEach { chunkId, chunkInputStream in
            let requestBuilder = VideosAPI.uploadWithUploadTokenWithRequestBuilder(token: token, file: chunkInputStream, chunkId: chunkId + 1, numOfChunks: numOfChunks, onProgressReady: nil)
            requestBuilders.append(requestBuilder)
        }
        try self.init(requestBuilders: requestBuilders, fileSize: file.fileSize, queueLabel: token, onProgressReady: onProgressReady, apiResponseQueue: apiResponseQueue, completion: completion)
        self.videoId = videoId
    }

    override func willExecuteRequestBuilder(requestBuilder: RequestBuilder<Video>) -> Void {
        if let videoId = videoId {
            VideosAPI.uploadAddVideoIdParameterWithRequestBuilder(requestBuilder: requestBuilder, videoId: videoId)
        }
        requestBuilder.onProgressReady = progressReadyHook
    }

    @available(iOS 11.0, macOS 10.13, macCatalyst 13.0, tvOS 11.0, watchOS 4.0, *)
    override public var progress: Progress {
        _progress.completedUnitCount = min(super.progress.completedUnitCount, _progress.totalUnitCount)
        return _progress
    }

    private func progressReadyHook(progress: Progress) -> Void {
        if let onProgressReady = onProgressReady {
            onProgressReady(progress)
        }
    }

    private func completionHook(_ data: Video?, _ error: Error?) -> Void {
        if let error = error {
            if !hasSentError {
                hasSentError = true
                cancel()
                completion(nil, error)
            }
        } else {
            if (videoId == nil) {
                videoId = data?.videoId
            }
            if (isFinished) {
                completion(data, nil)
            }
        }
    }
}
