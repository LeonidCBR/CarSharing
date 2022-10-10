//
//  MockApiClient.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 10.10.2022.
//

import Foundation
@testable import CarSharing

class MockApiClient: ApiClientProtocol {
    var result: Result<Data, NetworkError>!

    func downloadData(withUrl url: URL,
                      completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        print("DEBUG: Mock api client \(#function)")
        completionHandler(result)
    }
}
