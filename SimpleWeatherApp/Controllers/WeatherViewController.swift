//
//  WeatherViewController.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 24.05.2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    private let weatherView = WeatherView()
    private let viewModel = WeatherViewViewModel()
    
    var selectedCityId: Int = 745044

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        configureViewModel(with: selectedCityId)
    }
    
    private func setUpView() {
        view.addSubview(weatherView)
    
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            weatherView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
    }
    
    private func configureViewModel(with id: Int) {
        viewModel.delegate = self
        viewModel.fetchWeatherData(with: id)
    }

}

// MARK: Extensions
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item % 2 == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherSmallCollectionViewCell.cellIdentifier, for: indexPath) as? WeatherSmallCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            
            let data = viewModel.collectionViewData[indexPath.item]
            cell.configureLabels(title: data.title, value: data.value)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherBigCollectionViewCell.cellIdentifier, for: indexPath) as? WeatherBigCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            
            let data = viewModel.collectionViewData[indexPath.item]
            cell.configureLabels(title: data.title, value: data.value)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 30
        let cellHeight: CGFloat
        
        if indexPath.row % 2 == 0 {
            cellHeight = 80
        } else {
            cellHeight = 100
        }

        return CGSize(width: width, height: cellHeight)
    }
}

extension WeatherViewController: WeatherViewViewModelDelegate {
    func weatherDataDidUpdate(viewModel: WeatherViewViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.weatherView.configureHeaderAndDescriptionLabels(with: viewModel)
            
            if viewModel.seaLevel == 0 { viewModel.seaLevel = viewModel.pressure } // for when the city does not have sea level data

            self?.viewModel.collectionViewData = [
                (title: "Humidity", value: "%\(viewModel.humidity)"),
                (title: "Wind", value: "Speed: \(viewModel.windSpeed)km/h\n\nGust: \(viewModel.windGust)km/h"),
                (title: "Sea Level", value: "\(viewModel.seaLevel)"),
                (title: "Coordinates", value: "Latitude: \(viewModel.latitude)\n\nLongitude: \(viewModel.longitude)")
            ]

            self?.weatherView.collectionView.reloadData()
        }
    }
}

extension WeatherViewController: CitySelectionDelegate {
    func didSelectCity(cityId: Int) {
        selectedCityId = cityId
        configureViewModel(with: selectedCityId)
        tabBarController?.selectedIndex = 0
    }
}


