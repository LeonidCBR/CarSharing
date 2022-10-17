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
//    var handleFetchedCars: (() -> Void)? { get set }
//    var delegate: CarsharingProviderDelegate? { get set }
//    color: Double

    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car]
//    func getCars(from jsonData: Data) throws -> [Car]
}
