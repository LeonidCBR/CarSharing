//
//  CarsDecoderTests.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 18.05.2023.
//

import XCTest
@testable import CarSharing

final class CarsDecoderTests: XCTestCase {

    func testCarsDecoder_WhenValidDataWasProvidedFromCityDrive_ReturnCars() throws {
        let bundle = Bundle(for: CarsDecoderTests.self)
        let jsonURL = bundle.url(forResource: "citydrive",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonURL)

//        let cityDriveDecoder = CarsDecoder(providerType: .cityDrive)
        let cityDriveDecoder = CarsDecoder()
        let cars = try cityDriveDecoder.decode(from: jsonData, for: .cityDrive)

        XCTAssertEqual(cars.count, 3532)
        XCTAssertEqual(cars[3].providerType, .cityDrive)
        XCTAssertEqual(cars[3].model, "Nissan Qashqai")
        XCTAssertEqual(cars[3].number, "р950вк797")
        XCTAssertEqual(cars[3].lat, 56.024808, accuracy: 0.000001)
        XCTAssertEqual(cars[3].lon, 37.488716, accuracy: 0.000001)
        XCTAssertEqual(cars[3].fuel, 57)
        XCTAssertEqual(cars[3].distance, 9060244)
    }

    func testCarsDecoder_WhenValidDataWasProvidedFromYandexDrive_ReturnCars() throws {
        let bundle = Bundle(for: CarsDecoderTests.self)
        let jsonURL = bundle.url(forResource: "yandexdrive",
                                 withExtension: "json")!
        let jsonData = try Data(contentsOf: jsonURL)

//        let yandexDriveDecoder = CarsDecoder(providerType: .yandexDrive)
        let yandexDriveDecoder = CarsDecoder()
        let cars = try yandexDriveDecoder.decode(from: jsonData, for: .yandexDrive)

        XCTAssertEqual(cars.count, 4000)
        XCTAssertEqual(cars[3999].number, "т271км797")
        XCTAssertEqual(cars[3999].model, "volkswagen_polo_6")
        XCTAssertEqual(cars[1].providerType, .yandexDrive)
        XCTAssertEqual(cars[1].number, "у385км799")
        XCTAssertEqual(cars[1].model, "mercedes_e200")
        XCTAssertEqual(cars[1].lat, 55.91742991, accuracy: 0.0000001)
        XCTAssertEqual(cars[1].lon, 37.84304852, accuracy: 0.0000001)
        XCTAssertEqual(cars[1].fuel, 43)
        XCTAssertEqual(cars[1].distance, 283)
    }

    func testYandexDriveCarsharing_WhenCustomDataWasProvided_ReturnCars() throws {
        let jsonText = "{\"cars\":[{\"number\":\"у385км799\","
        + "\"model_id\":\"mercedes_e200\","
        + "\"location\":{\"lat\":55.91742991,\"lon\":37.84304852},"
        + "\"telematics\":{\"fuel_level\":43,\"fuel_distance\":283}},"
        + "{\"number\":\"н695ха750\",\"model_id\":\"skoda_octavia\","
        + "\"location\":{\"lat\":55.91742991,\"lon\":    37.84304852},"
        + "\"telematics\":{\"fuel_level\":43,\"fuel_distance\":283}}]}"
        let testJsonData = Data(jsonText.utf8)

//        let yandexDriveDecoder = CarsDecoder(providerType: .yandexDrive)
        let yandexDriveDecoder = CarsDecoder()
        let cars = try yandexDriveDecoder.decode(from: testJsonData, for: .yandexDrive)

        XCTAssertEqual(cars.count, 2)
        XCTAssertEqual(cars[0].number, "у385км799")
        XCTAssertEqual(cars[0].model, "mercedes_e200")
    }

}
