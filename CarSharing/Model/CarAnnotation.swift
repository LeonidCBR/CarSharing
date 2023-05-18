//
//  CarAnnotation.swift
//  CarSharing
//
//  Created by Яна Латышева on 21.10.2022.
//

import Foundation
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let providerType: ProviderType
    let title: String?
    let subtitle: String?

    init(with car: Car) {
        coordinate = CLLocationCoordinate2D(latitude: car.lat, longitude: car.lon)
        title = car.model
        subtitle = car.number
        providerType = car.providerType
        super.init()
    }
}
