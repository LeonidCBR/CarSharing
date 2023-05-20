//
//  MockCarsDecoder.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 20.05.2023.
//

import Foundation
@testable import CarSharing

final class MockCarsDecoder: CarsDecoderProtocol {
    var shouldReturnCars: [Car]!

    func decode(from data: Data,
                for providerType: CarSharing.ProviderType) throws -> [CarSharing.Car] {
        if data == Data("TEST".utf8) {
            return shouldReturnCars
        } else {
            return []
        }
    }
}
