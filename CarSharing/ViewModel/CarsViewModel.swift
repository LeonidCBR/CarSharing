//
//  CarsViewModel.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

final class CarsViewModel {
    private let apiClient: ApiClientProtocol
    private let carsharingProviders: [CarsharingProvider]
    private(set) var cars: [Car] = []
    // var errors: [Error]

    init(carsharingProviders: [CarsharingProvider], apiClient: ApiClientProtocol = ApiClient()) {
        self.carsharingProviders = carsharingProviders
        self.apiClient = apiClient
    }

    func fetchCars() { // completionHandler: (Result<[Car], Error>)->Void ??
        cars = []
        carsharingProviders.forEach { carsharingProvider in
            apiClient.downloadData(withUrl: carsharingProvider.apiUrl) { [weak self] result in
                print("DEBUG: Current thread is \(Thread.current)")
                switch result {
                case .success(let data):
                    // TODO: parse from data
                    print("DEBUG: carsharing parse from data \(data)")
                    guard let self = self else { return }
                    if let cars = try? carsharingProvider.getCars(from: data) {
                        self.cars.append(contentsOf: cars)
                    } else {
                        fatalError("DEBUG: Cannot get cars from data \(data)")
//                        throw NetworkError.unexpectedData
                    }
                case .failure(let error):
                    fatalError("DEBUG: Got error - \(error)")
//                    throw error
                }
            }
        }
    }
}
