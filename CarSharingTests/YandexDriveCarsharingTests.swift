//
//  YandexDriveCarsharingTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 07.10.2022.
//

import XCTest
@testable import CarSharing

class YandexDriveCarsharingTests: XCTestCase {
    var sut: YandexDriveCarsharing!

    override func setUp() {
        sut = YandexDriveCarsharing()
    }

    override func tearDown() {
        sut = nil
    }

    func testYandexDriveCarsharing_WhenCustomDataWasProvided_ReturnCars() throws {
        let jsonText = "{\"cars\":[{\"number\":\"у385км799\", \"model_id\":\"mercedes_e200\"},{\"number\":\"н695ха750\", \"model_id\":\"skoda_octavia\"}]}"
        let testJsonData = Data(jsonText.utf8)

        let cars = try sut.getCars(from: testJsonData)

        XCTAssertEqual(cars.count, 2)
        XCTAssertEqual(cars[0].number, "у385км799")
        XCTAssertEqual(cars[0].model, "mercedes_e200")
    }

    func testYandexDriveCarsharing_WhenValidDataWasProvided_ReturnCars() throws {
        let bundle = Bundle(for: YandexDriveCarsharingTests.self)
        let jsonUrl = bundle.url(forResource: "stable.carsharing.yandex.net-list",
                                       withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonUrl)
        let cars = try sut.getCars(from: jsonData)

        XCTAssertEqual(cars.count, 4000)
        XCTAssertEqual(cars[3999].number, "т271км797")
        XCTAssertEqual(cars[3999].model, "volkswagen_polo_6")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
