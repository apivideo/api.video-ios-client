//
// WebhooksAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class WebhooksAPI {

    /**
     Create Webhook
     
     - parameter webhooksCreationPayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func create(webhooksCreationPayload: WebhooksCreationPayload, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: Webhook?, _ error: Error?) -> Void)) -> RequestTask {
        return create(webhooksCreationPayload: webhooksCreationPayload, apiResponseQueue: apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Create Webhook
     
     - parameter webhooksCreationPayload: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the result of the request (incl. headers).
     */
    @discardableResult
    open class func create(webhooksCreationPayload: WebhooksCreationPayload, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping (_ result: Swift.Result<Response<Webhook>, ErrorResponse>) -> Void) -> RequestTask {
            return createWithRequestBuilder(webhooksCreationPayload: webhooksCreationPayload).execute(apiResponseQueue, completion)
    }


    /**
     Create Webhook
     - POST /webhooks
     - Webhooks can push notifications to your server, rather than polling api.video for changes. We currently offer four events:  * `video.encoding.quality.completed` Occurs when a new video is uploaded into your account, it will be encoded into several different HLS and mp4 qualities. When each version is encoded, your webhook will get a notification.  It will look like ```{ \"type\": \"video.encoding.quality.completed\", \"emittedAt\": \"2021-01-29T16:46:25.217+01:00\", \"videoId\": \"viXXXXXXXX\", \"encoding\": \"hls\", \"quality\": \"720p\"} ```. This request says that the 720p HLS encoding was completed. * `live-stream.broadcast.started`  When a live stream begins broadcasting, the broadcasting parameter changes from false to true, and this webhook fires. * `live-stream.broadcast.ended`  This event fires when a live stream has finished broadcasting. * `video.source.recorded`  This event occurs when a live stream is recorded and submitted for encoding. * `video.caption.generated`  This event occurs when an automatic caption has been generated. * `video.summary.generated`  This event occurs when an automatic summary has been generated.
     - responseHeaders: [X-RateLimit-Limit(Int), X-RateLimit-Remaining(Int), X-RateLimit-Retry-After(Int)]
     - parameter webhooksCreationPayload: (body)  
     - returns: RequestBuilder<Webhook> 
     */
    internal class func createWithRequestBuilder(webhooksCreationPayload: WebhooksCreationPayload) -> RequestBuilder<Webhook> {
        let localVariablePath = "/webhooks"
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: webhooksCreationPayload)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Webhook>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Retrieve Webhook details
     
     - parameter webhookId: (path) The unique webhook you wish to retreive details on. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func get(webhookId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: Webhook?, _ error: Error?) -> Void)) -> RequestTask {
        return get(webhookId: webhookId, apiResponseQueue: apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Retrieve Webhook details
     
     - parameter webhookId: (path) The unique webhook you wish to retreive details on. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the result of the request (incl. headers).
     */
    @discardableResult
    open class func get(webhookId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping (_ result: Swift.Result<Response<Webhook>, ErrorResponse>) -> Void) -> RequestTask {
            return getWithRequestBuilder(webhookId: webhookId).execute(apiResponseQueue, completion)
    }


    /**
     Retrieve Webhook details
     - GET /webhooks/{webhookId}
     - Retrieve webhook details by id.
     - responseHeaders: [X-RateLimit-Limit(Int), X-RateLimit-Remaining(Int), X-RateLimit-Retry-After(Int)]
     - parameter webhookId: (path) The unique webhook you wish to retreive details on. 
     - returns: RequestBuilder<Webhook> 
     */
    internal class func getWithRequestBuilder(webhookId: String) -> RequestBuilder<Webhook> {
        var localVariablePath = "/webhooks/{webhookId}"
        let webhookIdPreEscape = "\(APIHelper.mapValueToPathItem(webhookId))"
        let webhookIdPostEscape = webhookIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{webhookId}", with: webhookIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Webhook>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }


    /**
     Delete a Webhook
     
     - parameter webhookId: (path) The webhook you wish to delete. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func delete(webhookId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) -> RequestTask {
        return delete(webhookId: webhookId, apiResponseQueue: apiResponseQueue) { result in
            switch result {
            case .success:
                completion((), nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Delete a Webhook
     
     - parameter webhookId: (path) The webhook you wish to delete. 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the result of the request (incl. headers).
     */
    @discardableResult
    open class func delete(webhookId: String, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping (_ result: Swift.Result<Response<Void>, ErrorResponse>) -> Void) -> RequestTask {
            return deleteWithRequestBuilder(webhookId: webhookId).execute(apiResponseQueue, completion)
    }


    /**
     Delete a Webhook
     - DELETE /webhooks/{webhookId}
     - This method will delete the indicated webhook.
     - responseHeaders: [X-RateLimit-Limit(Int), X-RateLimit-Remaining(Int), X-RateLimit-Retry-After(Int)]
     - parameter webhookId: (path) The webhook you wish to delete. 
     - returns: RequestBuilder<Void> 
     */
    internal class func deleteWithRequestBuilder(webhookId: String) -> RequestBuilder<Void> {
        var localVariablePath = "/webhooks/{webhookId}"
        let webhookIdPreEscape = "\(APIHelper.mapValueToPathItem(webhookId))"
        let webhookIdPostEscape = webhookIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{webhookId}", with: webhookIdPostEscape, options: .literal, range: nil)
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
     List all webhooks
     
     - parameter events: (query) The webhook event that you wish to filter on. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects.
     */
    @discardableResult
    open class func list(events: String? = nil, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping ((_ data: WebhooksListResponse?, _ error: Error?) -> Void)) -> RequestTask {
        return list(events: events, currentPage: currentPage, pageSize: pageSize, apiResponseQueue: apiResponseQueue) { result in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     List all webhooks
     
     - parameter events: (query) The webhook event that you wish to filter on. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the result of the request (incl. headers).
     */
    @discardableResult
    open class func list(events: String? = nil, currentPage: Int? = nil, pageSize: Int? = nil, apiResponseQueue: DispatchQueue = ApiVideoClient.apiResponseQueue, completion: @escaping (_ result: Swift.Result<Response<WebhooksListResponse>, ErrorResponse>) -> Void) -> RequestTask {
            return listWithRequestBuilder(events: events, currentPage: currentPage, pageSize: pageSize).execute(apiResponseQueue, completion)
    }


    /**
     List all webhooks
     - GET /webhooks
     - Thie method returns a list of your webhooks (with all their details). 

You can filter what the webhook list that the API returns using the parameters described below.
     - responseHeaders: [X-RateLimit-Limit(Int), X-RateLimit-Remaining(Int), X-RateLimit-Retry-After(Int)]
     - parameter events: (query) The webhook event that you wish to filter on. (optional)
     - parameter currentPage: (query) Choose the number of search results to return per page. Minimum value: 1 (optional, default to 1)
     - parameter pageSize: (query) Results per page. Allowed values 1-100, default is 25. (optional, default to 25)
     - returns: RequestBuilder<WebhooksListResponse> 
     */
    internal class func listWithRequestBuilder(events: String? = nil, currentPage: Int? = nil, pageSize: Int? = nil) -> RequestBuilder<WebhooksListResponse> {
        let localVariablePath = "/webhooks"
        let localVariableURLString = ApiVideoClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "events": events?.encodeToJSON(),
            "currentPage": currentPage?.encodeToJSON(),
            "pageSize": pageSize?.encodeToJSON(),
        ])
        

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<WebhooksListResponse>.Type = ApiVideoClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

}
