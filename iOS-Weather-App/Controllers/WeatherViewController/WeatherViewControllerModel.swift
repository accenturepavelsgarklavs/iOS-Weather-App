//
//  WeatherViewControllerModel.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import MapKit
import CoreLocation
import Foundation

final class WeatherViewControllerModel {
    var onSearchTapped: (() -> Void)?

    func celsius(_ kelvin: Double?) -> Double {
        round((kelvin ?? 0) - 273.15)
    }
}