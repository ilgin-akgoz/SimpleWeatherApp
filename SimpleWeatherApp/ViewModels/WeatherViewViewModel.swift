//
//  WeatherViewViewModel.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 26.05.2023.
//

import UIKit

protocol WeatherViewViewModelDelegate: AnyObject {
    func weatherDataDidUpdate(viewModel: WeatherViewViewModel)
}

final class WeatherViewViewModel: NSObject {
    weak var delegate: WeatherViewViewModelDelegate?
    
    public var collectionViewData: [(title: String, value: String)] = []
        
    public var cityName: String = "Not set"
    public var currentTemperature: Int = 0
    public var feelsLike: Int = 0
    public var highestTemperature: Int = 0
    public var lowestTemperature: Int = 0
    public var weatherDescription: String = "Not set"
    public var humidity: Int = 0
    public var windSpeed: Int = 0
    public var windGust: Int = 0
    public var seaLevel: Int = 0
    public var pressure: Int = 0
    public var latitude: Int = 0
    public var longitude: Int = 0
    
    public func fetchWeatherData(with id: Int) {
        APIManager.shared.retrieveData (id: id) { [weak self] response in
            self?.cityName = response.name ?? "City"
            self?.currentTemperature = Int(response.main?.temp ?? 0.0)
            self?.feelsLike = Int(response.main?.feelsLike ?? 0.0)
            self?.highestTemperature = Int(response.main?.tempMax ?? 0.0)
            self?.lowestTemperature = Int(response.main?.tempMin ?? 0.0)
            
            self?.humidity = response.main?.humidity ?? 0
            self?.windSpeed = Int(response.wind?.speed ?? 0.0)
            self?.windGust = Int(response.wind?.gust ?? 0.0)
            self?.seaLevel = response.main?.seaLevel ?? 0
            self?.pressure = response.main?.pressure ?? 0
            self?.latitude = Int(response.coord?.lat ?? 0.0)
            self?.longitude = Int(response.coord?.lon ?? 0.0)
            
            self?.weatherDescription = response.weather?.first?.weatherDescription ?? "No description available"
                        
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.weatherDataDidUpdate(viewModel: self)
            }
        } fail: { error in
            print("Failed with error: \(error.localizedDescription)")
        }
    }

}


