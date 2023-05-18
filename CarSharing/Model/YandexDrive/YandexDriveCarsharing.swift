//
//  YandexDriveCarsharing.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation
/*
struct YandexDriveCarsharing: CarsharingProvider {
    var isEnabled: Bool
    var error: Error?

    // TODO: Move to Credentials
    let token = "TOKEN"

    // TODO: Remove it
    let apiClient: ApiClientProtocol
    let providerType: ProviderType = .yandexDrive

    var cars: [Car] = []

    init(with apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    init() {
        // TODO: Move it to VM
        let yandexSessionConfig = URLSessionConfiguration.default
        yandexSessionConfig.httpAdditionalHeaders = [
            "Authorization": "OAuth \(token)"
        ]
        let yandexSession = URLSession(configuration: yandexSessionConfig)
        apiClient = ApiClient(urlSession: yandexSession)
    }

    // TODO: Move it to VM
    @discardableResult
    func parseCars(from jsonData: Data) throws -> [Car] {
        if let yandexDriveFeed = try? JSONDecoder().decode(YandexDriveFeed.self, from: jsonData) {
            cars = yandexDriveFeed.cars
            return cars
        } else {
            throw NetworkError.unexpectedJSON
        }
    }

    // TODO: Move it to VM
    func downloadCars(completionHandler: @escaping (Result<[Car], NetworkError>) -> Void) {

        let urlString = ""

        // TODO: Implement as
        /*
         func sendRequest(_ url: String, parameters: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
             var components = URLComponents(string: url)!
             components.queryItems = parameters.map { (key, value) in
                 URLQueryItem(name: key, value: value)
             }
             components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
             let request = URLRequest(url: components.url!)
         */


        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("OAuth \(token)",
                         forHTTPHeaderField: "Authorization")

        // TODO: - Add params


        downloadCars(with: request, completionHandler: completionHandler)
    }

}
*/
