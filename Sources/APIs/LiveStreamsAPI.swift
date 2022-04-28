//
// LiveStreamsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class LiveStreamsAPI {

    /**
     Create live stream
     
     - parameter liveStreamCreationPayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func create(liveStreamCreationPayload: LiveStreamCreationPayload, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStream?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return createWithRequestBuilder(liveStreamCreationPayload: liveStreamCreationPayload).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Create live stream
     - POST /live-streams
     - A live stream will give you the 'connection point' to RTMP your video stream to api.video.  It will also give you the details for viewers to watch the same livestream.   The public=false 'private livestream' is available as a BETA feature, and should be limited to livestreams of 3,000 viewers or fewer.  See our [Live Stream Tutorial](https://api.video/blog/tutorials/live-stream-tutorial) for a walkthrough of this API with OBS.  Your RTMP endpoint for the livestream is rtmp://broadcast.api.video/s/{streamKey} Tutorials that [create live streams](https://api.video/blog/endpoints/live-create).
     - parameter liveStreamCreationPayload: (body)  
     - returns: RequestBuilder<LiveStream> 
     */
    open class func createWithRequestBuilder(liveStreamCreationPayload: LiveStreamCreationPayload) -> RequestBuilder<LiveStream> {
        let localVariablePath = "/live-streams"
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: liveStreamCreationPayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStream>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Retrieve live stream
     
     - parameter liveStreamId: (path) The unique ID for the live stream you want to watch. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func get(liveStreamId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStream?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return getWithRequestBuilder(liveStreamId: liveStreamId).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Retrieve live stream
     - GET /live-streams/{liveStreamId}
     - Supply a liveStreamId, and you'll get all the details for streaming into, and watching the livestream. Tutorials that use the [show livestream endpoint](https://api.video/blog/endpoints/live-stream-status).
     - parameter liveStreamId: (path) The unique ID for the live stream you want to watch. 
     - returns: RequestBuilder<LiveStream> 
     */
    open class func getWithRequestBuilder(liveStreamId: String) -> RequestBuilder<LiveStream> {
        var localVariablePath = "/live-streams/{liveStreamId}"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStream>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Update a live stream
     
     - parameter liveStreamId: (path) The unique ID for the live stream that you want to update information for such as player details, or whether you want the recording on or off. 
     - parameter liveStreamUpdatePayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func update(liveStreamId: String, liveStreamUpdatePayload: LiveStreamUpdatePayload, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStream?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return updateWithRequestBuilder(liveStreamId: liveStreamId, liveStreamUpdatePayload: liveStreamUpdatePayload).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Update a live stream
     - PATCH /live-streams/{liveStreamId}
     - Use this endpoint to update the player, or to turn recording on/off (saving a copy of the livestream).  NOTE: If the livestream is actively streaming, changing the recording status will only affect the NEXT stream.     The public=false \"private livestream\" is available as a BETA feature, and should be limited to livestreams of 3,000 viewers or fewer.
     - parameter liveStreamId: (path) The unique ID for the live stream that you want to update information for such as player details, or whether you want the recording on or off. 
     - parameter liveStreamUpdatePayload: (body)  
     - returns: RequestBuilder<LiveStream> 
     */
    open class func updateWithRequestBuilder(liveStreamId: String, liveStreamUpdatePayload: LiveStreamUpdatePayload) -> RequestBuilder<LiveStream> {
        var localVariablePath = "/live-streams/{liveStreamId}"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: liveStreamUpdatePayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStream>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Delete a live stream
     
     - parameter liveStreamId: (path) The unique ID for the live stream that you want to remove. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func delete(liveStreamId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return deleteWithRequestBuilder(liveStreamId: liveStreamId).execute(apiResponseQueue) { result in
                switch result {
                case .success:
                    completion((), nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Delete a live stream
     - DELETE /live-streams/{liveStreamId}
     - If you do not need a live stream any longer, you can send a request to delete it. All you need is the liveStreamId.
     - parameter liveStreamId: (path) The unique ID for the live stream that you want to remove. 
     - returns: RequestBuilder<Void> 
     */
    open class func deleteWithRequestBuilder(liveStreamId: String) -> RequestBuilder<Void> {
        var localVariablePath = "/live-streams/{liveStreamId}"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = ApiVideoClient.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     * enum for parameter sortOrder
     */
    public enum SortOrder_list: String, CaseIterable {
        case asc = "asc"
        case desc = "desc"
    }

    /**
     List all live streams
     
     - parameter streamKey: (query) The unique stream key that allows you to stream videos. (optional)
     - parameter name: (query) You can filter live streams by their name or a part of their name. (optional)
     - parameter sortBy: (query) Allowed: createdAt, publishedAt, name. createdAt - the time a livestream was created using the specified streamKey. publishedAt - the time a livestream was published using the specified streamKey. name - the name of the livestream. If you choose one of the time based options, the time is presented in ISO-8601 format. (optional)
     - parameter sortOrder: (query) Allowed: asc, desc. Ascending for date and time means that earlier values precede later ones. Descending means that later values preced earlier ones. For title, it is 0-9 and A-Z ascending and Z-A, 9-0 descending. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func list(streamKey: String? = nil, name: String? = nil, sortBy: String? = nil, sortOrder: SortOrder_list? = nil, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStreamListResponse?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return listWithRequestBuilder(streamKey: streamKey, name: name, sortBy: sortBy, sortOrder: sortOrder, currentPage: currentPage, pageSize: pageSize).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     List all live streams
     - GET /live-streams
     - With no parameters added to the url, this will return all livestreams. Query by name or key to limit the list.
     - parameter streamKey: (query) The unique stream key that allows you to stream videos. (optional)
     - parameter name: (query) You can filter live streams by their name or a part of their name. (optional)
     - parameter sortBy: (query) Allowed: createdAt, publishedAt, name. createdAt - the time a livestream was created using the specified streamKey. publishedAt - the time a livestream was published using the specified streamKey. name - the name of the livestream. If you choose one of the time based options, the time is presented in ISO-8601 format. (optional)
     - parameter sortOrder: (query) Allowed: asc, desc. Ascending for date and time means that earlier values precede later ones. Descending means that later values preced earlier ones. For title, it is 0-9 and A-Z ascending and Z-A, 9-0 descending. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - returns: RequestBuilder<LiveStreamListResponse> 
     */
    open class func listWithRequestBuilder(streamKey: String? = nil, name: String? = nil, sortBy: String? = nil, sortOrder: SortOrder_list? = nil, currentPage: Int? = nil, pageSize: Int? = nil) -> RequestBuilder<LiveStreamListResponse> {
        let localVariablePath = "/live-streams"
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "streamKey": streamKey?.encodeToJSON(),
            "name": name?.encodeToJSON(),
            "sortBy": sortBy?.encodeToJSON(),
            "sortOrder": sortOrder?.encodeToJSON(),
            "currentPage": currentPage?.encodeToJSON(),
            "pageSize": pageSize?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStreamListResponse>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Upload a thumbnail
     
     - parameter liveStreamId: (path) The unique ID for the live stream you want to upload. 
     - parameter file: (form) The image to be added as a thumbnail. The mime type should be image/jpeg, image/png or image/webp. The max allowed size is 8 MiB. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func uploadThumbnail(liveStreamId: String, file: URL, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStream?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return uploadThumbnailWithRequestBuilder(liveStreamId: liveStreamId, file: file).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Upload a thumbnail
     - POST /live-streams/{liveStreamId}/thumbnail
     - Upload an image to use as a backdrop for your livestream. Tutorials that [update live stream thumbnails](https://api.video/blog/endpoints/live-upload-a-thumbnail).
     - parameter liveStreamId: (path) The unique ID for the live stream you want to upload. 
     - parameter file: (form) The image to be added as a thumbnail. The mime type should be image/jpeg, image/png or image/webp. The max allowed size is 8 MiB. 
     - returns: RequestBuilder<LiveStream> 
     */
    open class func uploadThumbnailWithRequestBuilder(liveStreamId: String, file: URL) -> RequestBuilder<LiveStream> {
        var localVariablePath = "/live-streams/{liveStreamId}/thumbnail"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableFormParams: [String: Any?] = [
            "file": file.encodeToJSON(),
        ]
        let localVariableNonNullParameters = APIHelper.rejectNil(localVariableFormParams)
        let localVariableParameters = APIHelper.convertBoolToString(localVariableNonNullParameters)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "multipart/form-data",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStream>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Delete a thumbnail
     
     - parameter liveStreamId: (path) The unique identifier of the live stream whose thumbnail you want to delete. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func deleteThumbnail(liveStreamId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: LiveStream?, _ error: Error?) -> Void)) -> URLSessionTask? {
            return deleteThumbnailWithRequestBuilder(liveStreamId: liveStreamId).execute(apiResponseQueue) { result in
                switch result {
                case let .success(response):
                    completion(response.body, nil)
                case let .failure(error):
                    completion(nil, error)
                }
            }
    }


    /**
     Delete a thumbnail
     - DELETE /live-streams/{liveStreamId}/thumbnail
     - Send the unique identifier for a live stream to delete its thumbnail.
     - parameter liveStreamId: (path) The unique identifier of the live stream whose thumbnail you want to delete. 
     - returns: RequestBuilder<LiveStream> 
     */
    open class func deleteThumbnailWithRequestBuilder(liveStreamId: String) -> RequestBuilder<LiveStream> {
        var localVariablePath = "/live-streams/{liveStreamId}/thumbnail"
        let liveStreamIdPreEscape = "\(APIHelper.mapValueToPathItem(liveStreamId))"
        let liveStreamIdPostEscape = liveStreamIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{liveStreamId}", with: liveStreamIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<LiveStream>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

}
