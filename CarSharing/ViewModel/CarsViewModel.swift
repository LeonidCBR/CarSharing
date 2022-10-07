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
        carsharingProviders.forEach { carsharingProvider in
            apiClient.downloadData(withUrl: carsharingProvider.apiUrl) { result in
                switch result {
                case .success(let data):
                    // TODO: parse from data
                    print("DEBUG: carsharing parse from data \(data)")
                    if let cars = try? carsharingProvider.getCars(from: data) {
                        self.cars.append(contentsOf: cars)
                    } else {
                        fatalError("DEBUG: Cannot get cars from data \(data)")
                    }
                case .failure(let error):
                    fatalError("DEBUG: API client downloaded data with an error \(error)")
                }
            }
        }
    }
}
