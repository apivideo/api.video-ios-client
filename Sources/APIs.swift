// APIs.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
public class ApiVideoClient {
    public static var apiKey: String? = nil
    public static var basePath = "https://ws.api.video"
    internal static var customHeaders:[String: String] = ["AV-Origin-Client": "swift:1.3.5"]
    private static var chunkSize: Int = 50 * 1024 * 1024
    internal static var requestBuilderFactory: RequestBuilderFactory = AlamofireRequestBuilderFactory()
    internal static var credential = ApiVideoCredential()
    public static var apiResponseQueue: DispatchQueue = .main
    public static var timeout: TimeInterval = 60

    public static func setChunkSize(chunkSize: Int) throws {
        if (chunkSize > 128 * 1024 * 1024) {
            throw ParameterError.outOfRange
        } else if (chunkSize < 5 * 1024 * 1024) {
            throw ParameterError.outOfRange
        }
        
        ApiVideoClient.chunkSize = chunkSize
    }

    public static func getChunkSize() -> Int {
        return ApiVideoClient.chunkSize
    }

    static func isValid(pattern: String, field: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        let stringRange = NSRange(location: 0, length: field.utf16.count)
        let matches = regex.matches(in: field, range: stringRange)
        if(matches.isEmpty) {
            return false
        } else {
            return true
        }
    }

    static func isValidVersion(version: String) -> Bool {
        let pattern = #"^\d{1,3}(\.\d{1,3}(\.\d{1,3})?)?$"#
        return isValid(pattern: pattern, field: version)
    }

    static func isValidName(name: String) -> Bool {
        let pattern = #"^[\w\-]{1,50}$"#
        return isValid(pattern: pattern, field: name)
    }

    static func setName(key: String, name: String, version: String) throws {
        if(!isValidName(name: name)) {
            throw ParameterError.invalidName
        }
 
        if(!isValidVersion(version: version)) {
            throw ParameterError.invalidVersion
        }
        ApiVideoClient.customHeaders[key] = name + ":" + version
    }

    public static func setSdkName(name: String, version: String) throws {
        try setName(key: "AV-Origin-Sdk", name: name, version: version)
    }

    public static func setApplicationName(name: String, version: String) throws {
        try setName(key: "AV-Origin-App", name: name, version: version)
    }

}

open class RequestBuilder<T> {
    var headers: [String: String]
    public var parameters: [String: Any]?
    public let method: String
    public let URLString: String
    public let requestTask: RequestTask = RequestTask()

    /// Optional block to obtain a reference to the request's progress instance when available.
    public var onProgressReady: ((Progress) -> Void)?

    required public init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], onProgressReady: ((Progress) -> Void)? = nil) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.headers = headers
        self.onProgressReady = onProgressReady

        addHeaders(ApiVideoClient.customHeaders)
    }

    open func addHeaders(_ aHeaders: [String: String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }

    @discardableResult
    open func execute(_ apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, _ completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void) -> RequestTask {
        return requestTask
    }

    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }
}

public protocol RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type
}
