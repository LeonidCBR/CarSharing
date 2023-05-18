//
//  YandexDriveFeed.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

struct YandexDriveFeed: Feed, Decodable {
    let cars: [YandexDriveCar]

    var allCars: [Car] {
        return cars
    }

    enum CodingKeys: String, CodingKey {
        case cars = "cars"
    }
}
