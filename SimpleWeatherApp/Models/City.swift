//
//  City.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 26.05.2023.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    
    var idAndName: (Int, String) {
        return (id, name)
    }
}
