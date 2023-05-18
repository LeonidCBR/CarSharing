//
//  Provider.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

enum ProviderType: CustomStringConvertible {
    case yandexDrive
    case cityDrive

    var description: String {
        switch self {
        case .yandexDrive: return "Yandex Drive"
        case .cityDrive: return "City Drive"
        }
    }
}
