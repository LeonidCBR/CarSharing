//
//  CarsViewModel.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation
import OSLog

let carsViewModelLogger = Logger(subsystem: "CarSharing", category: "CarsViewModel")

final class CarsViewModel {
    private let credentialsProvider: CredentialsProviderProtocol
    private let requestProvider: RequestProviderProtocol
    private let networkProvider: NetworkProviderProtocol
    private let carsDecoder: CarsDecoderProtocol

    var carsharingProviders: [ProviderType]

    init(carsharingProviders: [ProviderType] = [],
         credentialsProvider: CredentialsProviderProtocol = CredentialsProvider(),
         requestProvider: RequestProviderProtocol = RequestProvider(),
         networkProvider: NetworkProviderProtocol = NetworkProvider(),
         carsDecoder: CarsDecoderProtocol = CarsDecoder()) {
        self.carsharingProviders = carsharingProviders
        self.networkProvider = networkProvider
        self.carsDecoder = carsDecoder
        self.credentialsProvider = credentialsProvider
        self.requestProvider = requestProvider
    }

    /// Returns all cars for all carsharing providers
    func fetchCars() async throws -> [Car] {
        var cars: [Car] = []
        // TODO: Make a concurrent perform
        // for await...
        // TODO: DO NOT interrupt the loop after getting errors
        for carsharingProvider in carsharingProviders {
            carsViewModelLogger.debug("\(#function) - \(carsharingProvider)")
            // TODO: Consider to use it
            let credentials = credentialsProvider.getCredentials(for: carsharingProvider)
            /// Prepare request
            let request = requestProvider.createRequest(for: carsharingProvider, with: credentials)
            /// Fetching data
            let data = try await networkProvider.downloadData(with: request)
            /// Parsing data
            let newCars = try carsDecoder.decode(from: data, for: carsharingProvider)
            // TODO: !!!Remember about CONCURRENCY!!! for-wait
            cars.append(contentsOf: newCars)
        }
        return cars

//        DispatchQueue.concurrentPerform(iterations: carsharingProviders.count) { index in
//            print("DEBUG: concurrent perfom with id \(index)")
//            let carsharingProvider = carsharingProviders[index]
//
//            carsharingProvider.downloadCars { [weak self] result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(_):
//                        self?.delegate?.didGetCars(carsharingProvider)
//                    case .failure(let error):
//                        self?.delegate?.didGetError(carsharingProvider,
//                                                    error: error)
//                    }
//                }
//            }
//        } //DispatchQueue.concurrentPerform
    }

}
