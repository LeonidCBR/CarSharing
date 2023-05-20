//
//  CarsDecoderProtocol.swift
//  CarSharing
//
//  Created by Яна Латышева on 20.05.2023.
//

import Foundation

protocol CarsDecoderProtocol {
    func decode(from data: Data, for providerType: ProviderType) throws -> [Car]
}
