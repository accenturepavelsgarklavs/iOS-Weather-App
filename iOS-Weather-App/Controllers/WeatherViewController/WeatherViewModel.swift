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

    func getWeather(location: CLLocation, completion: @escaping (Result<Weather, Error>) -> Void) {
        NetworkManager.getWeather(location: location, completion: { [weak self] result in
            DispatchQueue.main.async {
                if case .success(let weather) = result {
                    completion(.success(weather))
                } else if case .failure(let error) = result {
                    completion(.failure(error))
                }
            }
        })
    }
}