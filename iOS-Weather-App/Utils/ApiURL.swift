//
// Created by pavels.garklavs on 02/03/2022.
//

import Foundation
import CoreLocation

struct ApiURL {
    static func makeApiURL(location: CLLocation, units: String) -> URL? {
        var urlComponents = URLComponents()

        let queryItemLongitude = URLQueryItem(name: "lon", value: String(location.coordinate.longitude))
        let queryItemLatitude = URLQueryItem(name: "lat", value: String(location.coordinate.latitude))
        let queryItemUnits = URLQueryItem(name: "units", value: units)
        let queryItemAppID = URLQueryItem(name: "appid", value: Constants.APIKey)

        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"

        urlComponents.queryItems = [queryItemLongitude, queryItemLatitude, queryItemUnits, queryItemAppID]

        return urlComponents.url
    }
}
