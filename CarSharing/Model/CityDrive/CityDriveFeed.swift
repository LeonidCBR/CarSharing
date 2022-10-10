//
//  CityDriveFeed.swift
//  CarSharing
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation

struct CityDriveFeed: Decodable {
    let cars: [CityDriveCar]

    enum CodingKeys: String, CodingKey {
        case cars = "cars"
    }
}
