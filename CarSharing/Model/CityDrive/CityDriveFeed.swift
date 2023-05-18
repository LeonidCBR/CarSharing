//
//  CityDriveFeed.swift
//  CarSharing
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation

struct CityDriveFeed: Feed, Decodable {
    let cars: [CityDriveCar]

    var allCars: [Car] {
        return cars
    }

    enum CodingKeys: String, CodingKey {
        case cars = "cars"
    }
}
