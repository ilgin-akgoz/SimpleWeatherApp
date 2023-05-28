//
//  CitySelectionViewViewModel.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 27.05.2023.
//

import Foundation

final class CitySelectionViewViewModel {
    private var allCityIdAndNames: [(Int, String)] = []
    private var filteredCityIdAndNames: [(Int, String)] = []
    private var cityIdAndNames: [(Int, String)] = []
    
    private var isSearching: Bool {
        return !searchText.isEmpty
    }
        
    public var numberOfCities: Int {
        return isSearching ? filteredCityIdAndNames.count : cityIdAndNames.count
    }
    
    public var searchText: String = "" {
        didSet {
            filterCityIdAndNames()
        }
    }
    
    public func getCityName(at index: Int) -> String {
        return isSearching ? filteredCityIdAndNames[index].1 : cityIdAndNames[index].1
    }
        
    public func getSelectedCityId(at index: Int) -> Int {
        return isSearching ? filteredCityIdAndNames[index].0 : cityIdAndNames[index].0
    }
        
    public func loadCityIdAndNames() {
        guard let jsonURL = Bundle.main.url(forResource: "city.list", withExtension: "json"),
              let jsonData = try? Data(contentsOf: jsonURL) else {
            return
        }
            
        do {
            let jsonDecoder = JSONDecoder()
            let cities = try jsonDecoder.decode([City].self, from: jsonData)
            
            allCityIdAndNames = cities.map { $0.idAndName }
            
            cityIdAndNames = allCityIdAndNames.filter { (id, _) in
                CityIDs.ids.contains(id)
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
        
    private func filterCityIdAndNames() {
        filteredCityIdAndNames = allCityIdAndNames.filter {
            $0.1.localizedCaseInsensitiveContains(searchText)
        }
    }

}
