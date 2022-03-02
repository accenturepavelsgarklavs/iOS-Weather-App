//
//  WeatherViewModel.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import MapKit
import CoreLocation
import Foundation

final class WeatherViewModel {
    var onTableButton: ((CLLocation?) -> Void)?
    var onSearchTapped: (() -> Void)?
}