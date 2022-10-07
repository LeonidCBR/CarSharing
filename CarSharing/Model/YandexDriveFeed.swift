//
//  YandexDriveFeed.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

struct YandexDriveFeed: Decodable{
    let cars: [YandexDriveCar]

    enum CodingKeys: String, CodingKey {
        case cars = "cars"
    }
}
