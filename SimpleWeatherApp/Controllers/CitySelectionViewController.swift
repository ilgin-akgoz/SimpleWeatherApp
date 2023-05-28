//
//  CitySelectionViewController.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 24.05.2023.
//

import UIKit

protocol CitySelectionDelegate: AnyObject {
    func didSelectCity(cityId: Int)
}

final class CitySelectionViewController: UIViewController {
    weak var delegate: CitySelectionDelegate?
    private let citySelectionView = CitySelectionView()
    private let viewModel = CitySelectionViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cities"
        
        citySelectionView.tableView.dataSource = self
        citySelectionView.tableView.delegate = self
        citySelectionView.searchBar.delegate = self
        
        setUpView()
        viewModel.loadCityIdAndNames()
    }
    
    private func setUpView() {
        view.addSubview(citySelectionView)
    
        NSLayoutConstraint.activate([
            citySelectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citySelectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            citySelectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            citySelectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: Extensions
extension CitySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionTableViewCell.cellIdentifier, for: indexPath) as? CitySelectionTableViewCell else {
            fatalError("Unsupported cell")
        }
        
        let cityName = viewModel.getCityName(at: indexPath.row)
        cell.textLabel?.text = cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCityId = viewModel.getSelectedCityId(at: indexPath.row)
        delegate?.didSelectCity(cityId: selectedCityId)
    }
}

extension CitySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        citySelectionView.tableView.reloadData()
    }
}


