////
//// Created by pavels.garklavs on 22/02/2022.
////
//
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [WeatherElement]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
}

enum Description: String, Codable {

    // MARK: - Sky
    case clearSky = "clear sky"

    // MARK: - Cloud
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"

    // MARK: - Thunderstorm
    case thunderStormWithLightRain = "thunderstorm with light rain"
    case thunderstormWithRain = "thunderstorm with rain"
    case thunderstormWithHeavyRain = "thunderstorm with heavy rain"
    case lightThunderstorm = "light thunderstorm"
    case thunderstorm = "thunderstorm"
    case heavyThunderstorm = "heavy thunderstorm"
    case raggedThunderstorm = "ragged thunderstorm"
    case thunderstormWithLightDrizzle = "thunderstorm with light drizzle"
    case thunderstormWithDrizzle = "thunderstorm with drizzle"
    case thunderstormWithHeavyDrizzle = "thunderstorm with heavy drizzle"

    // MARK: - Drizzle
    case lightIntensityDrizzle = "light intensity drizzle"
    case drizzle = "drizzle"
    case heavyIntensityDrizzle = "heavy intensity drizzle"
    case lightIntensityDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyIntensityDrizzleRain = "heavy intensity drizzle rain"
    case showerRainAndDrizzle = "shower rain and drizzle"
    case heavyShowerRainAndDrizzle = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"

    // MARK: - Rain
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    case veryHeavyRain = "very heavy rain"
    case extremeRain = "extreme rain"
    case freezingRain = "freezing rain"
    case lightIntensityShowerRain = "light intensity shower rain"
    case showerRain = "shower rain"
    case heavyIntensityShowerRain = "heavy intensity shower rain"
    case raggedShowerRain = "ragged shower rain"

    // MARK: - Snow
    case lightSnow = "light snow"
    case snow = "snow"
    case heavySnow = "heavy snow"
    case sleet = "sleet"
    case lightShowerSleet = "light shower sleet"
    case showerSleet = "shower sleet"
    case lightRainAndSnow = "light rain and snow"
    case rainAndSnow = "rain and snow"
    case lightShowerSnow = "light shower snow"
    case showerSnow = "shower snow"
    case heavyShowerSnow = "heavy shower snow"

    // MARK: - Atmosphere
    case mist = "mist"
    case smoke = "smoke"
    case haze = "haze"
    case dustSand = "sand/ dust whirls"
    case dust = "dust"
    case fog = "fog"
    case sand = "sand"
    case ash = "volcanic ash"
    case squall = "squalls"
    case tornado = "tornado"

}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}