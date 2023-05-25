//
//  CarsViewModelTests.swift
//  CarSharingIntegrationTests
//
//  Created by Яна Латышева on 25.05.2023.
//

import XCTest
@testable import CarSharing

final class CarsViewModelTests: XCTestCase {
    var mockCredentialsProvider: MockCredentialsProvider!
    var sut: CarsViewModel!

    override func setUpWithError() throws {
        mockCredentialsProvider = MockCredentialsProvider()
        sut = CarsViewModel(carsharingProviders: [.yandexDrive],
                            credentialsProvider: mockCredentialsProvider)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockCredentialsProvider = nil
    }

    func testCarsViewModel_WhenProvideCredentialsFromPlist_ShouldReturnCars() async throws {
        let cars = try await sut.fetchCars()
        guard cars.count > 0 else {
            XCTFail("There is no cars")
            return
        }
    }

}
