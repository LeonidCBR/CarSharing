//
//  CarsDecoder.swift
//  CarSharing
//
//  Created by Яна Латышева on 18.05.2023.
//

import Foundation

struct CarsDecoder: CarsDecoderProtocol {

    func decode(from data: Data, for providerType: ProviderType) throws -> [Car] {
        do {
            // Decode the JSON data and get cars.
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            let carsharingFeed: Feed
            switch providerType {
            case .yandexDrive:
                carsharingFeed = try jsonDecoder.decode(YandexDriveFeed.self, from: data)
            case .cityDrive:
                carsharingFeed = try jsonDecoder.decode(CityDriveFeed.self, from: data)
            }
            return carsharingFeed.allCars
        } catch {
            throw CarError.wrongDataFormat(error: error)
        }
    }

}
