//
//  WeatherBigCollectionViewCell.swift
//  SimpleWeatherApp
//
//  Created by Ilgın Akgöz on 29.05.2023.
//

import UIKit

final class WeatherBigCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "WeatherBigCollectionViewCell"
    
    private let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(infoView, titleLabel, valueLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    public func configureLabels(title: String?, value: String?) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            infoView.leftAnchor.constraint(equalTo: leftAnchor),
            infoView.rightAnchor.constraint(equalTo: rightAnchor),
            infoView.widthAnchor.constraint(equalToConstant: 200),
            infoView.heightAnchor.constraint(equalToConstant: 100),
                    
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),

            valueLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            
        ])
    }
}
