//
//  CredentialsProviderProtocol.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

protocol CredentialsProviderProtocol {
    func getCredentials(for providerType: ProviderType) -> Credentials
    func saveCredentials(_ credentials: Credentials)
}
