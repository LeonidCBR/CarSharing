//
//  CarsViewModel.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation
import OSLog

let logger = Logger(subsystem: "CarSharing", category: "CarsViewModel")

protocol CarsViewModelDelegate: AnyObject {
    func didGetCars(_ cars: [Car])
    func didGetError(_ error: Error)
}

final class CarsViewModel {
//    private let apiClient: ApiClientProtocol
//    private let carsharingProviders: [CarsharingProvider]
    private(set) var cars: [Car] = []
    let carsharingProviders: [ProviderType]
    weak var delegate: CarsViewModelDelegate?

//    var numberOfProviders: Int {
//        return carsharingProviders.count
//    }

//    init(carsharingProviders: [CarsharingProvider], apiClient: ApiClientProtocol = ApiClient()) {
//        self.carsharingProviders = carsharingProviders
//        self.apiClient = apiClient
//    }
    init(carsharingProviders: [ProviderType]) {
        self.carsharingProviders = carsharingProviders
    }

//    init(carsharingProviders: [CarsharingProvider]) {
//        self.carsharingProviders = carsharingProviders
//    }

//    init() {
//        carsharingProviders = [YandexDriveCarsharing(), CityDriveCarsharing()]
//    }

    func fetchCars() {
//        let map: [ProviderType: CarsDecoder] = [ProviderType.cityDrive: CityDriveDecoder(),
//                                                ProviderType.yandexDrive: YandexDriveDecoder()]
        // TODO: Make a concurrent perform
        for carsharingProvider in carsharingProviders {
            // TODO: Implement the method
            logger.debug("\(#function) - \(carsharingProvider)")
            // get base URL and add important data (limit, user's location)
            // get parameters
            // fetch data
            // parse data
            // try? map[carsharingProvider]?.decode(from: Data())
            // append cars
        }

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
/*
    func numberOfCars(for carsharingProvider: CarsharingProvider) -> Int {
        return carsharingProvider.cars.count
    }

    func getAllCarsFor(carsharingProvider: CarsharingProvider) -> [Car] {
        return carsharingProvider.cars
    }
*/
}
