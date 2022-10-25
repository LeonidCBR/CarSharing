//
//  CityDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation

final class CityDriveCarsharing: CarsharingProvider {
    // TODO: Make as Constant
    let apiUrl = URL(string: "https://dummy-citydrive")!
    let provider: Provider = .cityDrive
    private(set) var cars: [Car] = []
//    {
//        didSet {
//            handleFetchedCars?()
//        }
//    }

//    var handleFetchedCars: (() -> Void)?

    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car] {
        if let cityDriveFeed = try? JSONDecoder().decode(CityDriveFeed.self, from: jsonData) {
            cars =  cityDriveFeed.cars
            return cars
        } else {
            throw NetworkError.unexpectedJSON
        }
    }

//    func getCars(from jsonData: Data) throws -> [Car] {
//        if let cityDriveFeed = try? JSONDecoder().decode(CityDriveFeed.self, from: jsonData) {
//            return cityDriveFeed.cars
//        } else {
//            throw NetworkError.unexpectedJSON
//        }
//    }
}
