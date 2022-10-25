//
//  Car.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

protocol Car {
    var model: String { get }
    var number: String { get }
    var lat: Double { get }
    var lon: Double { get }
    var provider: Provider { get }
    var fuel: Int { get }
    var distance: Int { get }
}
