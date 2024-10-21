//
// SummaryUpdatePayload.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct SummaryUpdatePayload: Codable, Hashable {

    /** A video title, based on the contents of the video. */
    public var title: String?
    /** A short outline of the contents of the video. */
    public var abstract: String?
    /** A list of 3 key points from the video, in chronological order. */
    public var takeaways: [String]?

    public init(title: String? = nil, abstract: String? = nil, takeaways: [String]? = nil) {
        self.title = title
        self.abstract = abstract
        self.takeaways = takeaways
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case title
        case abstract
        case takeaways
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(abstract, forKey: .abstract)
        try container.encodeIfPresent(takeaways, forKey: .takeaways)
    }
}

