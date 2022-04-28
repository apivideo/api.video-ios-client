//
// RawStatisticsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class RawStatisticsAPI {

    /**
     List live stream player sessions
     
     - parameter liveStreamId: (path) The unique identifier for the live stream you want to retrieve analytics for. 
     - parameter period: (query) Period must have one of the following formats:  - For a day : \&quot;2018-01-01\&quot;, - For a week: \&quot;2018-W01\&quot;,  - For a month: \&quot;2018-01\&quot; - For a year: \&quot;2018\&quot; For a range period:  -  Date range: \&quot;2018-01-01/2018-01-15\&quot;  (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func listLiveStreamSessions(liveStreamId: String, period: String? = nil, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: RawStatisticsListLiveStreamAnalyticsResponse?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return listLiveStreamSessionsWithRequestBuilder(liveStreamId: liveStreamId, period: period, currentPage: currentPage, pageSize: pageSize).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     List live stream player sessions
     - GET /analytics/live-streams/{liveStreamId}
     - parameter liveStreamId: (path) The unique identifier for the live stream you want to retrieve analytics for. 
     - parameter period: (query) Period must have one of the following formats:  - For a day : \&quot;2018-01-01\&quot;, - For a week: \&quot;2018-W01\&quot;,  - For a month: \&quot;2018-01\&quot; - For a year: \&quot;2018\&quot; For a range period:  -  Date range: \&quot;2018-01-01/2018-01-15\&quot;  (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - returns: RequestBuilder<RawStatisticsListLiveStreamAnalyticsResponse> 
     */
    open class func listLiveStreamSessionsWithRequestBuilder(liveStreamId: String, period: String? = nil, currentPage: Int? = nil, pageSize: Int? = nil) -> RequestBuilder<RawStatisticsListLiveStreamAnalyticsResponse> {
        var localVariablePath = "/analytics/live-streams/{liveStreamId}"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "period": period?.encodeToJSON(),
            "currentPage": currentPage?.encodeToJSON(),
            "pageSize": pageSize?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<RawStatisticsListLiveStreamAnalyticsResponse>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     List player session events
     
     - parameter sessionId: (path) A unique identifier you can use to reference and track a session with. 
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func listSessionEvents(sessionId: String, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: RawStatisticsListPlayerSessionEventsResponse?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return listSessionEventsWithRequestBuilder(sessionId: sessionId, currentPage: currentPage, pageSize: pageSize).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     List player session events
     - GET /analytics/sessions/{sessionId}/events
     - Useful to track and measure video's engagement.
     - parameter sessionId: (path) A unique identifier you can use to reference and track a session with. 
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - returns: RequestBuilder<RawStatisticsListPlayerSessionEventsResponse> 
     */
    open class func listSessionEventsWithRequestBuilder(sessionId: String, currentPage: Int? = nil, pageSize: Int? = nil) -> RequestBuilder<RawStatisticsListPlayerSessionEventsResponse> {
        var localVariablePath = "/analytics/sessions/{sessionId}/events"
        let sessionIdPreEscape = "\(APIHelper.mapValueToPathItem(sessionId))"
        let sessionIdPostEscape = sessionIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{sessionId}", with: sessionIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "currentPage": currentPage?.encodeToJSON(),
            "pageSize": pageSize?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<RawStatisticsListPlayerSessionEventsResponse>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     List video player sessions
     
     - parameter videoId: (path) The unique identifier for the video you want to retrieve session information for. 
     - parameter period: (query) Period must have one of the following formats:  - For a day : 2018-01-01, - For a week: 2018-W01,  - For a month: 2018-01 - For a year: 2018 For a range period:  -  Date range: 2018-01-01/2018-01-15  (optional)
     - parameter metadata: (query) Metadata and [Dynamic Metadata](https://api.video/blog/endpoints/dynamic-metadata) filter. Send an array of key value pairs you want to filter sessios with. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func listVideoSessions(videoId: String, period: String? = nil, metadata: [String: String]? = nil, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: RawStatisticsListSessionsResponse?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return listVideoSessionsWithRequestBuilder(videoId: videoId, period: period, metadata: metadata, currentPage: currentPage, pageSize: pageSize).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     List video player sessions
     - GET /analytics/videos/{videoId}
     - Retrieve all available user sessions for a specific video. Tutorials that use the [analytics endpoint](https://api.video/blog/endpoints/analytics).
     - parameter videoId: (path) The unique identifier for the video you want to retrieve session information for. 
     - parameter period: (query) Period must have one of the following formats:  - For a day : 2018-01-01, - For a week: 2018-W01,  - For a month: 2018-01 - For a year: 2018 For a range period:  -  Date range: 2018-01-01/2018-01-15  (optional)
     - parameter metadata: (query) Metadata and [Dynamic Metadata](https://api.video/blog/endpoints/dynamic-metadata) filter. Send an array of key value pairs you want to filter sessios with. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - returns: RequestBuilder<RawStatisticsListSessionsResponse> 
     */
    open class func listVideoSessionsWithRequestBuilder(videoId: String, period: String? = nil, metadata: [String: String]? = nil, currentPage: Int? = nil, pageSize: Int? = nil) -> RequestBuilder<RawStatisticsListSessionsResponse> {
        var localVariablePath = "/analytics/videos/{videoId}"
        let videoIdPreEscape = "\(APIHelper.mapValueToPathItem(videoId))"
        let videoIdPostEscape = videoIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{videoId}", with: videoIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "period": period?.encodeToJSON(),
            "metadata": metadata?.encodeToJSON(),
            "currentPage": currentPage?.encodeToJSON(),
            "pageSize": pageSize?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<RawStatisticsListSessionsResponse>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

}
