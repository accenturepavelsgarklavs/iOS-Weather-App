//
// Created by pavels.garklavs on 22/02/2022.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case badURL
    case badResponse
    case badStatusCode(Int)
    case badData
}

enum LocationError: Error {
    case badLocation
}

struct NetworkManager {
    static func getWeather(location: CLLocation? , completion: @escaping (Result<Weather, Error>) -> Void) {

        guard let location = location else {
            completion(.failure(LocationError.badLocation))
            return
        }

        let url = ApiURL.makeApiURL(location: location, units: "metric")

        guard let url = url else {
            completion(.failure(NetworkError.badURL))
            return
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                    completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.badResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkError.badStatusCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                    completion(.failure(NetworkError.badData))
                return
            }

            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weather))
            } catch let error {
                    completion(.failure(error))
            }
        }
        task.resume()
    }
}
