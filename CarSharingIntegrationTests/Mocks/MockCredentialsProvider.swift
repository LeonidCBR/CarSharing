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
        let bundle = Bundle(for: MockCredentialsProvider.self)
        let url = bundle.url(forResource: "YandexCredentials", withExtension: "plist")!
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Cannot get data!")
        }
        guard let plist = try? PropertyListSerialization.propertyList(from: data,
                                                                      format: nil)
                as? [String: AnyObject] else {
            fatalError("Cannot serialize data!")
        }
        guard let yaHost = plist["url"] as? String else {
            fatalError("Cannot get host from plist file!")
        }
        guard let params = plist["params"] as? [String: String] else {
            fatalError("Cannot get parameters from plist file!")
        }
        guard let headers = plist["headers"] as? [String: String] else {
            fatalError("Cannot get headers from plist file!")
        }
        let yandexDriveCredentials = Credentials(urlString: yaHost,
                                                            parameters: params,
                                                            headers: headers)
        print("DEBUG: Provide Yandex credentials ===>>>\n\(yandexDriveCredentials)")
        return yandexDriveCredentials
    }

    func saveCredentials(_ credentials: CarSharing.Credentials) {
        print("Mock saving credentials.")
    }
}
