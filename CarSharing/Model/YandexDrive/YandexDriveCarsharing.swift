//
//  YandexDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

final class YandexDriveCarsharing: CarsharingProvider {

    // TODO: Make as Constant

    let apiUrl = URL(string: "https://dummy-yandex")!
    let provider: Provider = .yandexDrive
    private(set) var cars: [Car] = []

    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car] {
        if let yandexDriveFeed = try? JSONDecoder().decode(YandexDriveFeed.self, from: jsonData) {
            cars = yandexDriveFeed.cars
            return cars
        } else {
            throw NetworkError.unexpectedJSON
        }
    }

}
