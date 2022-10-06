//
//  ApiClientTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 06.10.2022.
//

import XCTest
@testable import CarSharing

class ApiClientTests: XCTestCase {
    var sut: ApiClient!

    override func setUp() {
        let ephemeralConfig = URLSessionConfiguration.ephemeral
        ephemeralConfig.protocolClasses = [MockURLProtocol.self]
        let ephemeralUrlSession = URLSession(configuration: ephemeralConfig)
        
        sut = ApiClient(urlSession: ephemeralUrlSession)
    }

    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponse = nil
        MockURLProtocol.stubData = nil
        MockURLProtocol.error = nil
    }

    func testApiClient_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        let testUrl = URL(string: "https://localhost")!
        let testData =  Data("{\"status\":\"ok\"}".utf8)
        let testResponse = HTTPURLResponse(url: testUrl,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: ["Content-Type": "application/json"])
        let apiExpectation = expectation(description: "Api Client response expectation")

        MockURLProtocol.stubResponse = testResponse
        MockURLProtocol.stubData = testData
        MockURLProtocol.error = nil

        sut.downloadData(withUrl: testUrl) { result in

            guard case .success(let data) = result else {
                XCTFail("Expected to be a success but got a failure with \(result)")
                apiExpectation.fulfill()
                return
            }

            XCTAssertEqual(data, testData)
            apiExpectation.fulfill()
        }
        wait(for: [apiExpectation], timeout: 3)
    }

    // TODO: - create tests
    // there is an error
    // no response
    // status code 401 (unauthorized)
    // status code 3??
    // wrong mime type

}
