//
//  CarsViewModelTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 10.10.2022.
//

import XCTest
@testable import CarSharing

class CarsViewModelTests: XCTestCase {
    var sut: CarsViewModel!
    var mockApiClient: MockApiClient!

    override func setUp() {
        let carsharing = YandexDriveCarsharing()
        mockApiClient = MockApiClient()

        sut = CarsViewModel(carsharingProviders: [carsharing],
                            apiClient: mockApiClient)
    }

    override func tearDown()  {
        mockApiClient = nil
        sut = nil
    }

    func testCarsViewModel_WhenValidDataWasProvided_SaveCars() throws {
        let bundle = Bundle(for: CarsViewModelTests.self)
        let jsonUrl = bundle.url(forResource: "stable.carsharing.yandex.net-list",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonUrl)

        mockApiClient.result = .success(jsonData)
        sut.fetchCars()
        XCTAssertEqual(sut.cars.count, 4000)
        XCTAssertEqual(sut.cars[1].provider, .yandexDrive)
        XCTAssertEqual(sut.cars[1].number, "у385км799")
        XCTAssertEqual(sut.cars[1].model, "mercedes_e200")
        XCTAssertEqual(sut.cars[1].lat, 55.91742991, accuracy: 0.0000001)
        XCTAssertEqual(sut.cars[1].lon, 37.84304852, accuracy: 0.0000001)
        XCTAssertEqual(sut.cars[1].fuel, 43)
        XCTAssertEqual(sut.cars[1].distance, 283)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
