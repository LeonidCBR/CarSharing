//
//  YandexDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

final class YandexDriveCarsharing: CarsharingProvider {
    let apiUrl = URL(string: "https://dummy-yandex")!
//    private(set) var cars: [Car] = []

    func getCars(from jsonData: Data) throws -> [Car] {
        guard let yandexDriveFeed = try? JSONDecoder().decode(YandexDriveFeed.self, from: jsonData)
        else {
            throw NetworkError.unexpectedJSON
        }
//        cars = yandexDriveFeed.cars
        return yandexDriveFeed.cars

    }

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
