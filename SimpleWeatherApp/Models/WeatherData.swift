//
//  WeatherData.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 25.05.2023.
//

import Foundation

struct WeatherData: Decodable {
    let coord: Coordinates?
    let weather: [Weather]?
    let main: Main?
    let wind: Wind?
    let id: Int?
    let name: String?
    
    struct Coordinates: Decodable {
        let lon: Double?
        let lat: Double?
    }
    
    struct Weather: Decodable {
        let weatherDescription: String?
                
        private enum CodingKeys: String, CodingKey {
            case weatherDescription = "description"
        }
    }
    
    struct Main: Decodable {
        let temp: Double?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let humidity: Int?
        let seaLevel: Int?
        let pressure: Int?
        
        private enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
            case seaLevel = "sea_level"
            case pressure 
        }
    }
    
    struct Wind: Decodable {
        let speed: Double?
        let gust: Double?
    }
}

