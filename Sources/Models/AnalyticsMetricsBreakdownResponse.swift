//
// AnalyticsMetricsBreakdownResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AnalyticsMetricsBreakdownResponse: Codable, Hashable {

    public var context: AnalyticsMetricsBreakdownResponseContext
    /** Returns an array of dimensions and their respective metrics. */
    public var data: [AnalyticsMetricsBreakdownResponseData]
    public var pagination: Pagination

    public init(context: AnalyticsMetricsBreakdownResponseContext, data: [AnalyticsMetricsBreakdownResponseData], pagination: Pagination) {
        self.context = context
        self.data = data
        self.pagination = pagination
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case context
        case data
        case pagination
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(context, forKey: .context)
        try container.encode(data, forKey: .data)
        try container.encode(pagination, forKey: .pagination)
    }
}
