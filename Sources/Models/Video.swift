//
// Video.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Video: Codable, Hashable {

    /** The unique identifier of the video object. */
    public var videoId: String
    /** When a video was created, presented in ATOM UTC format. */
    public var createdAt: Date?
    /** The title of the video content.  */
    public var title: String?
    /** A description for the video content.  */
    public var description: String?
    /** The date and time the API created the video. Date and time are provided using ATOM UTC format. */
    public var publishedAt: Date?
    /** The date and time the video was updated. Date and time are provided using ATOM UTC format. */
    public var updatedAt: Date?
    /** The date and time the video was discarded. The API populates this field only if you have the Video Restore feature enabled and discard a video. Date and time are provided using ATOM UTC format. */
    public var discardedAt: Date?
    /** The date and time the video will be permanently deleted. The API populates this field only if you have the Video Restore feature enabled and discard a video. Discarded videos are pemanently deleted after 90 days. Date and time are provided using ATOM UTC format. */
    public var deletesAt: Date?
    /** Returns `true` for videos you discarded when you have the Video Restore feature enabled. Returns `false` for every other video. */
    public var discarded: Bool?
    /** One array of tags (each tag is a string) in order to categorize a video. Tags may include spaces.   */
    public var tags: [String]?
    /** Metadata you can use to categorise and filter videos. Metadata is a list of dictionaries, where each dictionary represents a key value pair for categorising a video.  */
    public var metadata: [Metadata]?
    public var source: VideoSource?
    public var assets: VideoAssets?
    /** The id of the player that will be applied on the video.  */
    public var playerId: String?
    /** Defines if the content is publicly reachable or if a unique token is needed for each play session. Default is true. Tutorials on [private videos](https://api.video/blog/endpoints/private-videos/).  */
    public var _public: Bool?
    /** Defines if video is panoramic.  */
    public var panoramic: Bool?
    /** This lets you know whether mp4 is supported. If enabled, an mp4 URL will be provided in the response for the video.  */
    public var mp4Support: Bool?

    public init(videoId: String, createdAt: Date? = nil, title: String? = nil, description: String? = nil, publishedAt: Date? = nil, updatedAt: Date? = nil, discardedAt: Date? = nil, deletesAt: Date? = nil, discarded: Bool? = nil, tags: [String]? = nil, metadata: [Metadata]? = nil, source: VideoSource? = nil, assets: VideoAssets? = nil, playerId: String? = nil, _public: Bool? = nil, panoramic: Bool? = nil, mp4Support: Bool? = nil) {
        self.videoId = videoId
        self.createdAt = createdAt
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
        self.discardedAt = discardedAt
        self.deletesAt = deletesAt
        self.discarded = discarded
        self.tags = tags
        self.metadata = metadata
        self.source = source
        self.assets = assets
        self.playerId = playerId
        self._public = _public
        self.panoramic = panoramic
        self.mp4Support = mp4Support
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case videoId
        case createdAt
        case title
        case description
        case publishedAt
        case updatedAt
        case discardedAt
        case deletesAt
        case discarded
        case tags
        case metadata
        case source
        case assets
        case playerId
        case _public = "public"
        case panoramic
        case mp4Support
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(videoId, forKey: .videoId)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(discardedAt, forKey: .discardedAt)
        try container.encodeIfPresent(deletesAt, forKey: .deletesAt)
        try container.encodeIfPresent(discarded, forKey: .discarded)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(assets, forKey: .assets)
        try container.encodeIfPresent(playerId, forKey: .playerId)
        try container.encodeIfPresent(_public, forKey: ._public)
        try container.encodeIfPresent(panoramic, forKey: .panoramic)
        try container.encodeIfPresent(mp4Support, forKey: .mp4Support)
    }
}

