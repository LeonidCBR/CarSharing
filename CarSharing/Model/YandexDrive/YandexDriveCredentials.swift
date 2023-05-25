//
//  YandexDriveCredentials.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

struct YandexDriveCredentials: Credentials {
    var urlString: String
    let parameters: [String: String]
    let headers: [String: String]
}
