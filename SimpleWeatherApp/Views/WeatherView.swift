//
//  WeatherView.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 24.05.2023.
//

import UIKit

final class WeatherView: UIView {
    private let viewModel = WeatherViewViewModel()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .regular)
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let highestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let lowestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isHidden = false
        collectionView.alpha = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: WeatherCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(headerView, collectionView, descriptionView)
        descriptionView.addSubview(descriptionLabel)
        headerView.addSubviews(cityLabel, currentTemperatureLabel, feelsLikeLabel, highestTemperatureLabel, lowestTemperatureLabel)
        
        setUpConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leftAnchor.constraint(equalTo: leftAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 8),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            highestTemperatureLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 16),
            highestTemperatureLabel.trailingAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -8),
            
            lowestTemperatureLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 16),
            lowestTemperatureLabel.leadingAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 8),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 80),
            descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: descriptionView.centerYAnchor),
        ])
    }
    
    public func configureHeaderAndDescriptionLabels(with viewModel: WeatherViewViewModel) {
        cityLabel.text = viewModel.cityName
        currentTemperatureLabel.text = "Current: \(viewModel.currentTemperature)°"
        feelsLikeLabel.text = "Feels Like: \(viewModel.feelsLike)°"
        highestTemperatureLabel.text = "H: \(viewModel.highestTemperature)°"
        lowestTemperatureLabel.text = "L: \(viewModel.lowestTemperature)°"
        descriptionLabel.text = "Today's weather has \(viewModel.weatherDescription)."
    }
}



