//
//  YandexDriveCredentials.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct YandexDriveCredentials: Credentials {
    let host: String

    var apiURL: URL? {
        return URL(string: "https://\(host)")
    }
}
