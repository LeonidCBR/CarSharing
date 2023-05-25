//
//  CarsViewModelTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 19.05.2023.
//

import XCTest
@testable import CarSharing

final class CarsViewModelTests: XCTestCase {
    var mockNetworkProvider: MockNetworkProvider!
    var mockCarsDecoder: MockCarsDecoder!
    var sut: CarsViewModel!

    override func setUpWithError() throws {
        mockNetworkProvider = MockNetworkProvider()
        mockCarsDecoder = MockCarsDecoder()
        sut = CarsViewModel(carsharingProviders: [.cityDrive],
                            networkProvider: mockNetworkProvider,
                            carsDecoder: mockCarsDecoder)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNetworkProvider = nil
        mockCarsDecoder = nil
    }

    func testCarsViewModel_WhenFetchingCarsSuccessful_ReturnsCars() async throws {
        let car1 = CityDriveCar(lat: 56.024808,
                                lon: 37.488716,
                                distance: 9060244,
                                fuel: 57,
                                model: "Nissan Qashqai",
                                number: "р950вк797")
        let car2 = CityDriveCar(lat: 56.1122,
                                lon: 37.4433,
                                distance: 9060245,
                                fuel: 47,
                                model: "Nissan Qashqai",
                                number: "р999рр797")
        let shouldReturnCars = [car1, car2]

        mockNetworkProvider.shouldReturnData = Data("TEST".utf8)
        mockCarsDecoder.shouldReturnCars = shouldReturnCars

        let cars = try await sut.fetchCars()

        guard cars.count == 2 else {
            XCTFail("It has been got \(cars.count) cars instead of 2")
            return
        }
        XCTAssertEqual(cars[0].providerType, .cityDrive)
        XCTAssertEqual(cars[0].model, "Nissan Qashqai")
        XCTAssertEqual(cars[0].number, "р950вк797")
        XCTAssertEqual(cars[0].lat, 56.024808, accuracy: 0.000001)
        XCTAssertEqual(cars[0].lon, 37.488716, accuracy: 0.000001)
        XCTAssertEqual(cars[0].fuel, 57)
        XCTAssertEqual(cars[0].distance, 9060244)
    }

}
