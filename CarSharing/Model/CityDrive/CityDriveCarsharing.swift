//
//  CityDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation
/*
struct CityDriveCarsharing: CarsharingProvider {
    var isEnabled: Bool
    var error: Error?

    let apiClient: ApiClientProtocol
//    let apiUrl = URL(string: "https://dummy-citydrive")!

    let providerType: ProviderType = .cityDrive
    private(set) var cars: [Car] = []


    init(with apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    init() {
        let cityDriveSessionConfig = URLSessionConfiguration.default
//        cityDriveSessionConfig.httpAdditionalHeaders = [
//            "Authorization": "OAuth \(token)"
//        ]
        let cityDriveSession = URLSession(configuration: cityDriveSessionConfig)
        apiClient = ApiClient(urlSession: cityDriveSession)
    }


    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car] {
        if let cityDriveFeed = try? JSONDecoder().decode(CityDriveFeed.self, from: jsonData) {
            cars =  cityDriveFeed.cars
            return cars
        } else {
            throw NetworkError.unexpectedJSON
        }
    }

    func downloadCars(completionHandler: @escaping (Result<[Car], NetworkError>) -> Void) {
        print("DEBUG: TODO: Implement downloading cars of city drive.")
        let urlString = "https://dummy.url"
        let request = URLRequest(url: URL(string: urlString)!)
        downloadCars(with: request, completionHandler: completionHandler)
    }

}
*/
