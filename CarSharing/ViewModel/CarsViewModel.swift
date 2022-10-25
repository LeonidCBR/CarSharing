//
//  CarsViewModel.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

protocol CarsViewModelDelegate: AnyObject {
    func didGetCars(_ carsharingProvider: CarsharingProvider)
    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error)
}

final class CarsViewModel {
    private let apiClient: ApiClientProtocol
    private let carsharingProviders: [CarsharingProvider]
//    private(set) var cars: [Car] = [] {
//        didSet {
//            delegate?.didGetCars()
//        }
//    }
//    private(set) var errors: [Error] = []
    weak var delegate: CarsViewModelDelegate?

    var numberOfProviders: Int {
        return carsharingProviders.count
    }

    init(carsharingProviders: [CarsharingProvider], apiClient: ApiClientProtocol = ApiClient()) {
        self.carsharingProviders = carsharingProviders
        self.apiClient = apiClient
    }

    func fetchCars() {
//    func fetchCars(completionHandler: @escaping (Result<[Car], Error>) -> Void) {

        DispatchQueue.concurrentPerform(iterations: carsharingProviders.count) { index in
            print("DEBUG: concurrent perfom with id \(index)")
            let carsharingProvider = carsharingProviders[index]

            apiClient.downloadData(withUrl: carsharingProvider.apiUrl) { [weak self] result in
                print("DEBUG: Current thread is \(Thread.current)")
                switch result {
                case .success(let data):
                    do {
                        try carsharingProvider.parseCars(from: data)
                        DispatchQueue.main.async {
                            self?.delegate?.didGetCars(carsharingProvider)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self?.delegate?.didGetError(carsharingProvider,
                                                        error: NetworkError.unexpectedData)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.delegate?.didGetError(carsharingProvider, error: error)
                    }
                }
            }

        } //DispatchQueue.concurrentPerform

    }

    func numberOfCars(for carsharingProvider: CarsharingProvider) -> Int {
        return carsharingProvider.cars.count
    }

    func getAllCarsFor(carsharingProvider: CarsharingProvider) -> [Car] {
        return carsharingProvider.cars
    }

//    func getCarsForRegion(lat: Double, lon: Double, delta: Double, carsharingProvider: CarsharingProvider) -> [Car] {
//        return carsharingProvider.cars.filter { car in
//            return (car.lat < lat + delta) && (car.lat > lat - delta)
//            && (car.lon < lon + delta) && (car.lon > lon - delta)
//        }
//    }
}
