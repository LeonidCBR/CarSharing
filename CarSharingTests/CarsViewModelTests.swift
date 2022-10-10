//
//  CarsViewModelTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 10.10.2022.
//

import XCTest
@testable import CarSharing

//class CarsVMDelegate: CarsViewModelDelegate {
//    func didGetCars() {
//    }
//
//    func didGetError(_ error: Error) {
//    }
//}

class CarsViewModelTests: XCTestCase {
    var sut: CarsViewModel!
    var mockApiClient: MockApiClient!
    var carsExpectation: XCTestExpectation!

    override func setUp() {
        let carsharing = YandexDriveCarsharing()
        mockApiClient = MockApiClient()

        sut = CarsViewModel(carsharingProviders: [carsharing],
                            apiClient: mockApiClient)
        sut.delegate = self
    }

    override func tearDown()  {
        carsExpectation = nil
        mockApiClient = nil
        sut = nil
    }

    func testCarsViewModel_WhenFetchCars_ShouldCallDelegates() throws {
        let bundle = Bundle(for: CarsViewModelTests.self)
        let jsonUrl = bundle.url(forResource: "stable.carsharing.yandex.net-list",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonUrl)
        mockApiClient.result = .success(jsonData)
        carsExpectation = expectation(description: "Cars View Model expectation")

        sut.fetchCars()

        wait(for: [carsExpectation], timeout: 5)
    }
/*
    func testCarsViewModel_WhenFetchData_ShouldReturnCars() throws {
        let bundle = Bundle(for: CarsViewModelTests.self)
        let jsonUrl = bundle.url(forResource: "stable.carsharing.yandex.net-list",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonUrl)
        mockApiClient.result = .success(jsonData)
        let carsExpectation = expectation(description: "Cars View Model expectation")

        sut.fetchCars { result in

            guard case .success(let cars) = result else {
                XCTFail("Expected to be a success but got a failure with \(result)")
                carsExpectation.fulfill()
                return
            }

            XCTAssertEqual(cars.count, 4000)
            XCTAssertEqual(cars[1].provider, .yandexDrive)
            XCTAssertEqual(cars[1].number, "у385км799")
            XCTAssertEqual(cars[1].model, "mercedes_e200")
            XCTAssertEqual(cars[1].lat, 55.91742991, accuracy: 0.0000001)
            XCTAssertEqual(cars[1].lon, 37.84304852, accuracy: 0.0000001)
            XCTAssertEqual(cars[1].fuel, 43)
            XCTAssertEqual(cars[1].distance, 283)
            carsExpectation.fulfill()
        }

        wait(for: [carsExpectation], timeout: 3)
    }
*/


//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}


extension CarsViewModelTests: CarsViewModelDelegate {
    func didGetCars(_ carsharingProvider: CarsharingProvider) {
        XCTAssertEqual(carsharingProvider.cars.count, 4000)
        XCTAssertEqual(carsharingProvider.cars[1].provider, .yandexDrive)
        XCTAssertEqual(carsharingProvider.cars[1].number, "у385км799")
        XCTAssertEqual(carsharingProvider.cars[1].model, "mercedes_e200")
        XCTAssertEqual(carsharingProvider.cars[1].lat, 55.91742991, accuracy: 0.0000001)
        XCTAssertEqual(carsharingProvider.cars[1].lon, 37.84304852, accuracy: 0.0000001)
        XCTAssertEqual(carsharingProvider.cars[1].fuel, 43)
        XCTAssertEqual(carsharingProvider.cars[1].distance, 283)
        carsExpectation.fulfill()
    }

    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error) {
        XCTFail()
        carsExpectation.fulfill()
    }
}
