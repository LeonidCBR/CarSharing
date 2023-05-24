//
//  MockCredentialsProvider.swift
//  CarSharingTests
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation
@testable import CarSharing

final class MockCredentialsProvider: CredentialsProviderProtocol {
    func getCredentials(for providerType: CarSharing.ProviderType) -> CarSharing.Credentials {
        // TODO: Read data from plist
        let yaHost = "dummy-host"

        let yandexDriveCredentials = YandexDriveCredentials(host: yaHost)
        return yandexDriveCredentials
    }

    func saveCredentials(_ credentials: CarSharing.Credentials) {
        print("Mock saving credentials.")
    }
}
