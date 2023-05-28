//
//  TabBarController.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 24.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setUpTabs()
    }
    
    private func setUpTabs() {
        let weatherVC = WeatherViewController()
        let citySelectionVC = CitySelectionViewController()
        
        citySelectionVC.delegate = weatherVC
        
        let nav1 = UINavigationController(rootViewController: weatherVC)
        let nav2 = UINavigationController(rootViewController: citySelectionVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "location.circle"), tag: 2)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}

