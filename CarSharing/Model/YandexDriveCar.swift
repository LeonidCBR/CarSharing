//
//  YandexDriveCar.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

struct YandexDriveCar: Car, Decodable {
    let model: String
    let number: String

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case model = "model_id"
    }
//    var model: String {
//        return "yandex model"
//    }

//    var number: String {
//        return "yandex number"
//    }
//    location -> return
}
