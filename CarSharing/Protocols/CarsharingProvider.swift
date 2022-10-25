//
//  CarsharingProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

protocol CarsharingProvider {
    var apiUrl: URL { get }
    var cars: [Car] { get }
    var provider: Provider { get }

    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car]
}
