//
//  RequestProviderProtocol.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

protocol RequestProviderProtocol {
    func createRequest(with credentials: Credentials) throws -> URLRequest
}
