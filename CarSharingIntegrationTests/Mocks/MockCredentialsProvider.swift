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
//        let resource: String
//        switch providerType {
//        case .yandexDrive:
//            resource = "YandexCredentials"
//        case .cityDrive:
//            resource = "CityCredentials"
//        }
//        guard let path = Bundle.main.path(forResource: "YandexCredentials",
//                                          ofType: "plist") else {
//            fatalError("Cannot get path to a file with credentials!")
//        }
        let bundle = Bundle(for: MockCredentialsProvider.self)
        let url = bundle.url(forResource: "YandexCredentials", withExtension: "plist")!
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Cannot get data!")
        }
        guard let plist = try? PropertyListSerialization.propertyList(from: data,
                                                                      format: nil)
                as? [String: String] else {
            fatalError("Cannot serialize data!")
        }
        guard let yaHost = plist["host"] else {
            fatalError("Cannot get host from plist!")
        }
        let yandexDriveCredentials = YandexDriveCredentials(host: yaHost)
        print("DEBUG: Provide Yandex credentials ===>>>\n\(yandexDriveCredentials)")
        return yandexDriveCredentials
    }

    func saveCredentials(_ credentials: CarSharing.Credentials) {
        print("Mock saving credentials.")
    }
}
