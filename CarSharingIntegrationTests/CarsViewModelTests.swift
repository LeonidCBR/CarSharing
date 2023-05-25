//
//  CarsViewModelTests.swift
//  CarSharingIntegrationTests
//
//  Created by Яна Латышева on 25.05.2023.
//

import XCTest
@testable import CarSharing

final class CarsViewModelTests: XCTestCase {
    var sut: CarsViewModel!

    override func setUpWithError() throws {
        // TODO: rename and to andNetworkProvider
//        sut = CarsViewModel(with: [.yandexDrive], and: <#T##NetworkProviderProtocol#>, and: <#T##CarsDecoderProtocol#>, and: <#T##CredentialsProviderProtocol#>)

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCarsViewModel_WhenProvideCredentialsFromPlist_ShouldReturnCars() throws {
    }

}
