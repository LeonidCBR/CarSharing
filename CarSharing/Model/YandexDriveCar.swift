//
//  YandexDriveCar.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

struct YandexDriveCar: Car, Decodable {

    struct Telematics: Decodable {
        let fuel_level: Int
        let fuel_distance: Int
    }

    let location: Location
    let telematics: Telematics
    let provider: Provider = .yandexDrive
    let model: String
    let number: String

    var fuel: Int {
        return telematics.fuel_level
    }

    var distance: Int {
        return telematics.fuel_distance
    }

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case model = "model_id"
        case location = "location"
        case telematics = "telematics"
    }

}
