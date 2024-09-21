//
//  HourForecastCollectionCell.swift
//  weatherForecast
//
//  Created by eva on 19.09.2024.
//

import UIKit
import Foundation

class HourForecastCollectionCell : UICollectionViewCell {
    
    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var gradusLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        return label
    }()

    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
    }

    private func setupSubviews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(gradusLabel)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.0),
            
            gradusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gradusLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4.0),
            
            contentView.bottomAnchor.constraint(equalTo: gradusLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    // MARK: - Public

    func setup(with model: CityModelHourForecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: model.time)
        
        if let date {
            dateFormatter.dateFormat = "HH:mm"
            timeLabel.text = dateFormatter.string(from: date)
        }
        
        gradusLabel.text = "\(model.getTemp())°"
    }
        
}
