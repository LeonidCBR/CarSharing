//
//  CarsViewModel.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

//protocol CarsViewModelDelegate: AnyObject {
//    func didGetCars()
//    func didGetError(_ error: Error)
//}

final class CarsViewModel {
    private let apiClient: ApiClientProtocol
    private let carsharingProviders: [CarsharingProvider]
//    private(set) var cars: [Car] = [] {
//        didSet {
//            delegate?.didGetCars()
//        }
//    }
//    private(set) var errors: [Error] = []
//    weak var delegate: CarsViewModelDelegate?

    init(carsharingProviders: [CarsharingProvider], apiClient: ApiClientProtocol = ApiClient()) {
        self.carsharingProviders = carsharingProviders
        self.apiClient = apiClient
    }

    func fetchCars(completionHandler: @escaping (Result<[Car], Error>) -> Void) {
        var cars: [Car] = []

        // TODO: Consider to use
        DispatchQueue.concurrentPerform(iterations: carsharingProviders.count) { index in
            print("DEBUG: concurrent perfom with id \(index)")
        }

        carsharingProviders.forEach { carsharingProvider in
            apiClient.downloadData(withUrl: carsharingProvider.apiUrl) { result in
//                guard let self = self else { return }
                print("DEBUG: Current thread is \(Thread.current)")
                switch result {
                case .success(let data):
                    if let fetchedCars = try? carsharingProvider.getCars(from: data) {
                        cars.append(contentsOf: fetchedCars)
                    } else {
                        completionHandler(.failure(NetworkError.unexpectedData))
//                        DispatchQueue.main.async {
//                            self.delegate?.didGetError()
//                        }
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
//                    DispatchQueue.main.async {
//                        self.delegate?.didGetError(error)
//                    }
                }
            }
        }

        completionHandler(.success(cars))
//        DispatchQueue.main.async {
//            self.cars = currentCars
//        }
    }
}
