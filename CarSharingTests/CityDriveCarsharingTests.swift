//
//  CityDriveCarsharingTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 10.10.2022.
//

import XCTest
@testable import CarSharing

class CityDriveCarsharingTests: XCTestCase {
    var sut: CityDriveCarsharing!

    override func setUp() {
        sut = CityDriveCarsharing()
    }

    override func tearDown() {
        sut = nil
    }

    func testCityDriveCarsharing_WhenValidDataWasProvided_ReturnCars() throws {
        let bundle = Bundle(for: CityDriveCarsharingTests.self)
        let jsonUrl = bundle.url(forResource: "api.citydrive.ru-status",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonUrl)
        
        let cars = try sut.getCars(from: jsonData)

        XCTAssertEqual(cars.count, 3532)
        XCTAssertEqual(cars[3].provider, .cityDrive)
        XCTAssertEqual(cars[3].model, "Nissan Qashqai")
        XCTAssertEqual(cars[3].number, "р950вк797")
        XCTAssertEqual(cars[3].lat, 56.024808, accuracy: 0.000001)
        XCTAssertEqual(cars[3].lon, 37.488716, accuracy: 0.000001)
        XCTAssertEqual(cars[3].fuel, 57)
        XCTAssertEqual(cars[3].distance, 9060244)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
