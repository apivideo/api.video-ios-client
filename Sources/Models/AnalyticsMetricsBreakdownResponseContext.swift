//
// AnalyticsMetricsBreakdownResponseContext.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AnalyticsMetricsBreakdownResponseContext: Codable, Hashable {

    public enum Metric: String, Codable, CaseIterable {
        case play = "play"
        case playRate = "play-rate"
        case start = "start"
        case end = "end"
        case impression = "impression"
        case ccvAverage = "ccv-average"
        case ccvPeak = "ccv-peak"
        case uniqueCcvAverage = "unique-ccv-average"
        case uniqueCcvPeak = "unique-ccv-peak"
        case view3 = "view-3"
        case view5 = "view-5"
        case view10 = "view-10"
        case view30 = "view-30"
        case uniqueView = "unique-view"
        case uniqueView3 = "unique-view-3"
        case uniqueView5 = "unique-view-5"
        case uniqueView10 = "unique-view-10"
        case uniqueView30 = "unique-view-30"
    }
    public enum Breakdown: String, Codable, CaseIterable {
        case mediaId = "media-id"
        case mediaType = "media-type"
        case continent = "continent"
        case country = "country"
        case deviceType = "device-type"
        case operatingSystem = "operating-system"
        case browser = "browser"
    }
    /** Returns the metric and relevant parameters you selected. */
    public var metric: Metric?
    /** Returns the dimension you selected. */
    public var breakdown: Breakdown?
    public var timeframe: AnalyticsAggregatedMetricsResponseContextTimeframe?

    public init(metric: Metric? = nil, breakdown: Breakdown? = nil, timeframe: AnalyticsAggregatedMetricsResponseContextTimeframe? = nil) {
        self.metric = metric
        self.breakdown = breakdown
        self.timeframe = timeframe
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case metric
        case breakdown
        case timeframe
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(metric, forKey: .metric)
        try container.encodeIfPresent(breakdown, forKey: .breakdown)
        try container.encodeIfPresent(timeframe, forKey: .timeframe)
    }
}

