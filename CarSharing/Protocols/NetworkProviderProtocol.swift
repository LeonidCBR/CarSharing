//
//  NetworkProviderProtocol.swift
//  CarSharing
//
//  Created by Яна Латышева on 19.05.2023.
//

import Foundation

protocol NetworkProviderProtocol {
    func downloadData(withUrl url: URL) async throws -> Data
    func downloadData(with request: URLRequest) async throws -> Data
}
