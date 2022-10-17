//
//  YandexDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

final class YandexDriveCarsharing: CarsharingProvider {
    // TODO: Make as Constant
    let apiUrl = URL(string: "https://dummy-yandex")!
    private(set) var cars: [Car] = []
//    {
//        didSet {
//            handleFetchedCars?()
//        }
//    }



//    var handleFetchedCars: (() -> Void)?

    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car] {
        if let yandexDriveFeed = try? JSONDecoder().decode(YandexDriveFeed.self, from: jsonData) {
            cars = yandexDriveFeed.cars
            return cars
        } else {
            throw NetworkError.unexpectedJSON
        }
    }

//    func getCars(from jsonData: Data) throws -> [Car] {
//        if let yandexDriveFeed = try? JSONDecoder().decode(YandexDriveFeed.self, from: jsonData) {
//            // cars = yandexDriveFeed.cars
//            return yandexDriveFeed.cars
//        } else {
//            throw NetworkError.unexpectedJSON
//        }
//    }

//    struct Models {
//        let model_id: String,
//        let imageUrl: String, // json key "image"
//        let name: String
//    }
//
//    private models: Models // cotainer

//    cars: [YandexDriveCar] = []
//
//    init() {}
//
//    parse(from data: Data) {
//        cars = JSONDecoder.decode(YandexDriveCarsharing.self, from: data)
//    }
}
