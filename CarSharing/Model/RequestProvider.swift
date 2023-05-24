//
//  RequestProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct RequestProvider: RequestProviderProtocol {
    func createRequest(for providerType: ProviderType, with credentials: Credentials) -> URLRequest {
        guard let apiURL = credentials.apiURL else {
            fatalError("Cannot get API URL for \(providerType) provider!")
        }
        // TODO: Implement
        let request = URLRequest(url: apiURL)
        return request
    }

}
