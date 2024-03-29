//
//  ApiClient.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import Foundation

final class NetworkProvider: NetworkProviderProtocol {
    // MARK: - Properties

    private let urlSession: URLSession

    // MARK: - Lifecycle

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    // MARK: - Methods

    func downloadData(withUrl url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let data = try await downloadData(with: request)
        return data
    }

    func downloadData(with request: URLRequest) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request)
        // Check response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        // Check status code
        let code = httpResponse.statusCode
        if !(200...299).contains(code) {
            if code == 401 {
                throw NetworkError.unauthorized
            } else {
                throw NetworkError.unhandledError(code)
            }
        }
        // Check mime type
        guard let mimeType = httpResponse.mimeType,
              (mimeType == "application/json") || ( mimeType.hasPrefix("image") ) else {
                  throw NetworkError.unexpectedData
              }
        return data
    }

}
