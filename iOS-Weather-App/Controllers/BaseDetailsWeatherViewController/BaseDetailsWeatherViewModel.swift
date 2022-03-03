//
// Created by pavels.garklavs on 28/02/2022.
//

import UIKit
import CoreLocation

class BaseDetailsWeatherViewModel {
    func makeWindLabelText(windSpeed: Double) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "wind")
        let fullString = NSMutableAttributedString(string: " ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: "\(String(windSpeed))m/s"))

        return fullString
    }

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
