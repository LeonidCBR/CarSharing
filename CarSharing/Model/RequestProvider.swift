//
//  RequestProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct RequestProvider: RequestProviderProtocol {
    func createRequest(for providerType: ProviderType, with credentials: Credentials) throws -> URLRequest {
        let params = credentials.parameters
        let headers = credentials.headers
        var endpointURLString = credentials.urlString + "?"
        for key in params.keys {
            endpointURLString.append("\(key)=\(params[key] ?? "")&")
        }
        // Removing trail "&"
        endpointURLString.remove(at: endpointURLString.index(before: endpointURLString.endIndex))
        print("DEBUG: Endpoint \(endpointURLString)")
        guard let endpointURL = URL(string: endpointURLString) else {
            throw NetworkError.unexpectedURL
        }
        let request = URLRequest(url: endpointURL)

        // TODO: Add the headers in the request

        return request
    }

}
