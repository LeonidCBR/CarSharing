//
//  CityDriveCar.swift
//  CarSharing
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation

struct CityDriveCar: Car, Decodable {

    let lat: Double
    let lon: Double
    let distance: Int
    let fuel: Int
    let provider: Provider = .cityDrive
    let model: String
    let number: String

    enum CodingKeys: String, CodingKey {
        case model = "model"
        case number = "number"
        case lat = "lat"
        case lon = "lon"
        case distance = "distance"
        case fuel = "fuel"
    }
}
