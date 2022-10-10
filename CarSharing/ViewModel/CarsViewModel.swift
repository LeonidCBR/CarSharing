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

    func numberOfCars(for carsharingProvider: CarsharingProvider) -> Int {
        return carsharingProvider.cars.count
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
                        try carsharingProvider.fetchCars(from: data)
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
}
