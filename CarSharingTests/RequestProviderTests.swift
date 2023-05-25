//
//  RequestProviderTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 25.05.2023.
//

import XCTest
@testable import CarSharing

final class RequestProviderTests: XCTestCase {
    var sut: RequestProvider!

    override func setUpWithError() throws {
        sut = RequestProvider()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testRequestProvider_WhenCredentialsProviden_ShouldReturnRequest() throws {
        let url = "https://my.site.com/api"
        let params = ["first": "111", "second": "222"]
        let headers = ["some": "data", "another": "raw"]
        let credentials = Credentials(urlString: url,
                                      parameters: params,
                                      headers: headers)
        let request = try sut.createRequest(with: credentials)
        guard let host = request.url?.host else {
            XCTFail("Cannot get host")
            return
        }
        guard let relativePath = request.url?.relativePath else {
            XCTFail("Cannot get path")
            return
        }
        XCTAssertEqual(host, "my.site.com")
        XCTAssertEqual(relativePath, "/api")
        // TODO: Check parameters
        let value = request.value(forHTTPHeaderField: "some")
        XCTAssertEqual(value, "data")
    }

}
