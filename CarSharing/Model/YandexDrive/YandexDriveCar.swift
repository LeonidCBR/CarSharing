//
//  YandexDriveCar.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

struct YandexDriveCar: Car, Decodable {
    let providerType: ProviderType = .yandexDrive

    struct Telematics: Decodable {
        let fuelLevel: Int
        let fuelDistance: Int
        enum CodingKeys: String, CodingKey {
            case fuelLevel = "fuel_level"
            case fuelDistance = "fuel_distance"
        }
    }

    private let location: Location
    let telematics: Telematics
    let model: String
    let number: String

    var lat: Double {
        return location.lat
    }

    var lon: Double {
        return location.lon
    }

    var fuel: Int {
        return telematics.fuelLevel
    }

    var distance: Int {
        return telematics.fuelDistance
    }

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case model = "model_id"
        case location = "location"
        case telematics = "telematics"
    }

}
