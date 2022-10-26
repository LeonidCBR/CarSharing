//
//  MockApiClient.swift
//  CarSharing
//
//  Created by Яна Латышева on 17.10.2022.
//

import Foundation

class MockApiClient: ApiClientProtocol {
    func downloadData(withUrl url: URL, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        print("DEBUG: Fake downloading data from \(url.absoluteString)")
        let mockUrl: URL
        if url.absoluteString == "https://dummy-yandex" {
            mockUrl = Bundle.main.url(forResource: "stable.carsharing.yandex.net-list",
                                      withExtension: "json")!
        } else if url.absoluteString == "https://dummy-citydrive" {
            mockUrl = Bundle.main.url(forResource: "api.citydrive.ru-status",
                                      withExtension: "json")!
        } else {
            fatalError("DEBUG: Wrong url!")
        }
        let mockData = try! Data(contentsOf: mockUrl)
        let result: Result<Data, NetworkError>

        result = .success(mockData)
//        result = .failure(.unauthorized)

        let waitSeconds = Double(Int.random(in: 2...5))

        DispatchQueue.global().asyncAfter(deadline: .now() + waitSeconds) {
            completionHandler(result)
        }
    }
}
