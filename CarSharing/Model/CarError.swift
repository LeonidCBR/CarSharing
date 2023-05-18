//
//  CarError.swift
//  CarSharing
//
//  Created by Яна Латышева on 18.05.2023.
//

import Foundation

enum CarError: Error {
    case missingData
    case wrongDataFormat(error: Error)
}

extension CarError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("There is no data", comment: "")
        case .wrongDataFormat(let error):
            return NSLocalizedString(
                "Could not digest the fetched data. \(error.localizedDescription)",
                comment: "")
        }
    }
}
