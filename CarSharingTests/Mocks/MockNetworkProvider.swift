//
//  MockNetworkProvider.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 19.05.2023.
//

import Foundation
@testable import CarSharing

final class MockNetworkProvider: NetworkProviderProtocol {
    var shouldReturnData: Data!

    func downloadData(withUrl url: URL) async throws -> Data {
        return shouldReturnData
    }

    func downloadData(with request: URLRequest) async throws -> Data {
        return shouldReturnData
    }

}
