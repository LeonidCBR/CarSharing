//
//  Credentials.swift
//  CarSharing
//
//  Created by Яна Латышева on 24.05.2023.
//

import Foundation

protocol Credentials {
    var urlString: String { get }
    var parameters: [String: String] { get }
    var headers: [String: String] { get }
}
