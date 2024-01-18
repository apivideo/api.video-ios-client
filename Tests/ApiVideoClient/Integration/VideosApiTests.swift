//  VideosApiTests.swift
//

import Foundation
import XCTest
import ApiVideoClient

internal class UploadTestCase: XCTestCase {
    internal var videoId: String? = nil

    override func setUpWithError() throws {
        try super.setUpWithError()
        try XCTSkipIf(Parameters.apiKey == "INTEGRATION_TESTS_API_KEY", "Can't get API key")
        ApiVideoClient.setApiKey(Parameters.apiKey)
        ApiVideoClient.basePath = Environment.sandbox.rawValue
        try? ApiVideoClient.setApplicationName(name: "client-integration-tests", version: "0")

        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()

        if let videoId = videoId {
            VideosAPI.delete(videoId: videoId) { data, error in
            }
        }
    }

    internal func createVideo() {
        let expectation = XCTestExpectation(description: "Create a video")

        VideosAPI.create(videoCreationPayload: VideoCreationPayload(title: "[iOS-API-client-tests] \(self.name)")) { video, error in
            XCTAssertNil(error, "Failed to create a video due to \(String(describing: error))")
            XCTAssertNotNil(video, "Failed to create a video")
            if let video = video {
                self.videoId = video.videoId
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    internal func uploadVideo(file: URL, timeout: TimeInterval = 30) {
        let expectation = XCTestExpectation(description: "Upload a video")
        var observedProgress: Progress? = nil

        do {
            try VideosAPI.upload(videoId: self.videoId!, file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNotNil(video, "Failed to upload a video")
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                expectation.fulfill()
            }
        } catch {
            XCTFail("Failed to upload a video due to \(error)")
        }

        wait(for: [expectation], timeout: timeout)

        XCTAssertNotNil(observedProgress, "Failed to get progress")
        XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
    }
}

class SingleUploadTests: UploadTestCase {
    func testUpload() {
        createVideo()

        uploadVideo(file: SharedResources.v558k!)
    }
}

class UploadChunkTests: UploadTestCase {
    func testUpload() throws {
        createVideo()

        try ApiVideoClient.setChunkSize(1024 * 1024 * 5)
        uploadVideo(file: SharedResources.v10m!, timeout: 120)
    }
}

class ProgressiveUploadTests: UploadTestCase {
    private var progressiveUploadSession: VideosAPI.ProgressiveUploadSession? = nil

    @discardableResult
    private func uploadPart(file: URL, isLastPart: Bool = false, timeout: TimeInterval = 60, expectation: XCTestExpectation = XCTestExpectation(description: "Upload a video part")) -> RequestTask {
        var observedProgress: Progress? = nil
        var requestTask: RequestTask!

        if (isLastPart) {
            requestTask = progressiveUploadSession!.uploadLastPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        } else {
            requestTask = progressiveUploadSession!.uploadPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        }

        if (timeout > 0) {
            wait(for: [expectation], timeout: timeout)
        }

        return requestTask
    }

    /// Wait for a part to be uploaded before trying to upload a new part
    func testSyncUpload() {
        createVideo()

        progressiveUploadSession = VideosAPI.buildProgressiveUploadSession(videoId: self.videoId!)
        uploadPart(file: SharedResources.v10m_parta!)
        uploadPart(file: SharedResources.v10m_partb!)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true)
    }

    /// Add all the part to the upload queue
    func testStackedUpload() {
        createVideo()

        let expectation = XCTestExpectation(description: "Upload a video part")
        expectation.expectedFulfillmentCount = 3

        progressiveUploadSession = VideosAPI.buildProgressiveUploadSession(videoId: self.videoId!)
        uploadPart(file: SharedResources.v10m_parta!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partb!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true, timeout: 0, expectation: expectation)
        wait(for: [expectation], timeout: 180)
    }
}


internal class UploadWithTokenTestCase: XCTestCase {
    internal var token: String? = nil

    override func setUpWithError() throws {
        try super.setUpWithError()
        try XCTSkipIf(Parameters.apiKey == "INTEGRATION_TESTS_API_KEY", "Can't get API key")
        ApiVideoClient.setApiKey(Parameters.apiKey)
        ApiVideoClient.basePath = Environment.sandbox.rawValue

        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()

        if let token = self.token {
            UploadTokensAPI.deleteToken(uploadToken: token) { data, error in
            }
        }
    }

    internal func createUploadToken() {
        let expectation = XCTestExpectation(description: "Create an upload token")

        UploadTokensAPI.createToken(tokenCreationPayload: TokenCreationPayload(ttl: 120)) { uploadToken, error in
            XCTAssertNil(error, "Failed to create a an upload token due to \(String(describing: error))")
            XCTAssertNotNil(uploadToken, "Failed to create an upload token")
            if let uploadToken = uploadToken {
                self.token = uploadToken.token
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    internal func uploadVideo(file: URL, timeout: TimeInterval = 30) {
        let expectation = XCTestExpectation(description: "Upload a video")
        var observedProgress: Progress? = nil

        do {
            try VideosAPI.uploadWithUploadToken(token: self.token!, file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNotNil(video, "Failed to upload a video")
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                expectation.fulfill()
            }
        } catch {
            XCTFail("Failed to upload a video with upload token due to \(error)")
        }

        wait(for: [expectation], timeout: timeout)

        XCTAssertNotNil(observedProgress, "Failed to get progress")
        XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
    }
}

class SingleUploadWithTokenTests: UploadWithTokenTestCase {
    func testUpload() {
        createUploadToken()

        uploadVideo(file: SharedResources.v558k!)
    }
}

class UploadWithTokenChunkTests: UploadWithTokenTestCase {
    func testUpload() throws {
        createUploadToken()

        try ApiVideoClient.setChunkSize(1024 * 1024 * 5)
        uploadVideo(file: SharedResources.v10m!, timeout: 120)
    }
}

class ProgressiveUploadWithTokenTests: UploadWithTokenTestCase {
    private var progressiveUploadSession: VideosAPI.ProgressiveUploadWithUploadTokenSession? = nil

    @discardableResult
    private func uploadPart(file: URL, isLastPart: Bool = false, timeout: TimeInterval = 60, expectation: XCTestExpectation = XCTestExpectation(description: "Upload a video part")) -> RequestTask {
        var observedProgress: Progress? = nil
        var requestTask: RequestTask!

        if (isLastPart) {
            requestTask = progressiveUploadSession!.uploadLastPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        } else {
            requestTask = progressiveUploadSession!.uploadPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        }

        if (timeout > 0) {
            wait(for: [expectation], timeout: timeout)
        }

        return requestTask
    }


    /// Wait for a part to be uploaded before trying to upload a new part
    func testSyncUpload() {
        createUploadToken()

        progressiveUploadSession = VideosAPI.buildProgressiveUploadWithUploadTokenSession(token: self.token!)
        uploadPart(file: SharedResources.v10m_parta!)
        uploadPart(file: SharedResources.v10m_partb!)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true)
    }

    /// Add all the part to the upload queue
    func testStackedUpload() {
        createUploadToken()

        let expectation = XCTestExpectation(description: "Upload a video part")
        expectation.expectedFulfillmentCount = 3

        progressiveUploadSession = VideosAPI.buildProgressiveUploadWithUploadTokenSession(token: self.token!)
        uploadPart(file: SharedResources.v10m_parta!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partb!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true, timeout: 0, expectation: expectation)
        wait(for: [expectation], timeout: 180)
    }
}

internal class UploadWithTokenAndVideoIdTestCase: XCTestCase {
    internal var token: String? = nil
    internal var videoId: String? = nil

    override func setUpWithError() throws {
        try super.setUpWithError()
        try XCTSkipIf(Parameters.apiKey == "INTEGRATION_TESTS_API_KEY", "Can't get API key")
        ApiVideoClient.setApiKey(Parameters.apiKey)
        ApiVideoClient.basePath = Environment.sandbox.rawValue

        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()

        if let token = self.token {
            UploadTokensAPI.deleteToken(uploadToken: token) { data, error in
            }
        }
        if let videoId = self.videoId {
            VideosAPI.delete(videoId: videoId) { data, error in
            }
        }
    }

    internal func createUploadToken() {
        let expectation = XCTestExpectation(description: "Create an upload token")

        UploadTokensAPI.createToken(tokenCreationPayload: TokenCreationPayload(ttl: 120)) { uploadToken, error in
            XCTAssertNil(error, "Failed to create a an upload token due to \(String(describing: error))")
            XCTAssertNotNil(uploadToken, "Failed to create an upload token")
            if let uploadToken = uploadToken {
                self.token = uploadToken.token
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    internal func createVideo() {
        let expectation = XCTestExpectation(description: "Create a video")

        VideosAPI.create(videoCreationPayload: VideoCreationPayload(title: "[iOS-API-client-tests] \(self.name)")) { video, error in
            XCTAssertNil(error, "Failed to create a video due to \(String(describing: error))")
            XCTAssertNotNil(video, "Failed to create a video")
            if let video = video {
                self.videoId = video.videoId
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    internal func uploadVideo(file: URL, timeout: TimeInterval = 30) {
        let expectation = XCTestExpectation(description: "Upload a video")
        var observedProgress: Progress? = nil

        do {
            try VideosAPI.uploadWithUploadToken(token: self.token!, file: file, videoId: self.videoId!, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNotNil(video, "Failed to upload a video")
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                expectation.fulfill()
            }
        } catch {
            XCTFail("Failed to upload a video with upload token due to \(error)")
        }

        wait(for: [expectation], timeout: timeout)

        XCTAssertNotNil(observedProgress, "Failed to get progress")
        XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
    }
}

class SingleUploadWithTokenAndVideoIdTests: UploadWithTokenAndVideoIdTestCase {
    func testUpload() {
        createUploadToken()
        createVideo()

        uploadVideo(file: SharedResources.v558k!)
    }
}

class ProgressiveUploadWithTokenAndVideoIdTests: UploadWithTokenAndVideoIdTestCase {
    private var progressiveUploadSession: VideosAPI.ProgressiveUploadWithUploadTokenSession? = nil

    @discardableResult
    private func uploadPart(file: URL, isLastPart: Bool = false, timeout: TimeInterval = 60, expectation: XCTestExpectation = XCTestExpectation(description: "Upload a video part")) -> RequestTask {
        var observedProgress: Progress? = nil
        var requestTask: RequestTask!

        if (isLastPart) {
            requestTask = progressiveUploadSession!.uploadLastPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        } else {
            requestTask = progressiveUploadSession!.uploadPart(file: file, onProgressReady: { progress in
                observedProgress = progress
            }) { video, error in
                XCTAssertNil(error, "Failed to upload a video due to \(String(describing: error))")
                XCTAssertNotNil(video, "Failed to upload a video")
                if (error == nil) {
                    XCTAssertNotNil(observedProgress, "Failed to get progress")
                    XCTAssertEqual(1.0, observedProgress?.fractionCompleted)
                }
                expectation.fulfill()
            }
        }

        if (timeout > 0) {
            wait(for: [expectation], timeout: timeout)
        }

        return requestTask
    }


    /// Wait for a part to be uploaded before trying to upload a new part
    func testSyncUpload() {
        createUploadToken()
        createVideo()

        progressiveUploadSession = VideosAPI.buildProgressiveUploadWithUploadTokenSession(token: self.token!, videoId: self.videoId!)
        uploadPart(file: SharedResources.v10m_parta!)
        uploadPart(file: SharedResources.v10m_partb!)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true)
    }

    /// Add all the part to the upload queue
    func testStackedUpload() {
        createUploadToken()
        createVideo()

        let expectation = XCTestExpectation(description: "Upload a video part")
        expectation.expectedFulfillmentCount = 3

        progressiveUploadSession = VideosAPI.buildProgressiveUploadWithUploadTokenSession(token: self.token!, videoId: self.videoId!)
        uploadPart(file: SharedResources.v10m_parta!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partb!, timeout: 0, expectation: expectation)
        uploadPart(file: SharedResources.v10m_partc!, isLastPart: true, timeout: 0, expectation: expectation)
        wait(for: [expectation], timeout: 180)
    }
}

class UpdateTests: XCTestCase {
    func testPlayerIdEncoding() {
        do {
            let json1 = try CodableHelper.jsonEncoder.encode(VideoUpdatePayload(playerId: nil, title: "title"))
            XCTAssertFalse(String(decoding: json1, as: UTF8.self).contains("playerId"))

            let json2 = try CodableHelper.jsonEncoder.encode(VideoUpdatePayload(playerId: NullableString.NULL, title: "title"))
            XCTAssertTrue(String(decoding: json2, as: UTF8.self).contains("\"playerId\" : null"))

            let json3 = try CodableHelper.jsonEncoder.encode(VideoUpdatePayload(playerId: NullableString(value: "1234"), title: "title"))
            XCTAssertTrue(String(decoding: json3, as: UTF8.self).contains("\"playerId\" : \"1234\""))
        } catch {

        }
    }
}