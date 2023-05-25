//
//  CredentialsProvider.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct CredentialsProvider: CredentialsProviderProtocol {

    func getCredentials(for providerType: ProviderType) -> Credentials {
        // TODO: Get credentials from UserDefaults
        return YandexDriveCredentials(urlString: "dummy-host", parameters: [:], headers: [:])
    }

    func saveCredentials(_ credentials: Credentials) {
        // TODO: Save credentials to UserDefault
    }

}
