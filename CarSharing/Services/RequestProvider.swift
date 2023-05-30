//
//  RequestProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct RequestProvider: RequestProviderProtocol {
    func createRequest(with credentials: Credentials) throws -> URLRequest {
        // Adding parameters to request
        let params = credentials.parameters
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
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "GET"
        // Adding headers to request
        let headers = credentials.headers
        for key in headers.keys {
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
        return request
    }

}
