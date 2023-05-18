//
//  CarsharingProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation
/*
protocol CarsharingProvider {
    var cars: [Car] { get set }
    var error: Error? { get set }
    var isEnabled: Bool { get set }

    // TODO: Refactor - move it to CarsDecoder
    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car]

    // TODO: Refactor - move it to the view model
    func downloadCars(completionHandler: @escaping (Result<[Car], NetworkError>) -> Void)
    func downloadCars(with request: URLRequest, completionHandler: @escaping (Result<[Car], NetworkError>) -> Void)
}

extension CarsharingProvider {
    func downloadCars(with request: URLRequest, completionHandler: @escaping (Result<[Car], NetworkError>) -> Void) {
        apiClient.downloadData(with: request) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    if let cars = try self?.parseCars(from: data) {
                        completionHandler(.success(cars))
                    }
                } catch {
                    completionHandler(.failure(NetworkError.unexpectedData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
*/
