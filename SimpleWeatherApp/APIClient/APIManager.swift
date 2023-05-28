//
//  APIManager.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 25.05.2023.
//

import Foundation

final class APIManager {
    public static let shared = APIManager()
    
    func retrieveData(id: Int, success: @escaping ((WeatherData) -> Void), fail: @escaping ((Error) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/weather?APPID=9396ebe90d9ffa93f8868694387a8afe&units=metric&id=\(id)"
        
        ServiceManager.shared.callService(urlString: url) {
            (response: WeatherData) in
            success(response)
        } fail: { error in
            fail(error)
        }
    }
}
