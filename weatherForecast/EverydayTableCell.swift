//
//  EverydayTableCell.swift
//  weatherForecast
//
//  Created by eva on 19.09.2024.
//

import UIKit

class EverydayTableCell : UITableViewCell {
    
    //MARK: - Subviews
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
    
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var humidityImageView: UIImageView = {
        let image = UIImageView(image: .humidity)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
    
        label.textColor = .main
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
    
        label.textColor = .black
        
        return label
    }()
    
    private lazy var gradusesLabel: UILabel = {
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
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
        )
        
        setupView()
        setupSubviews()
        
        setupLayoutsMain()
    }

    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10.0
        contentView.backgroundColor = .tableCell
    }
    
    private func setupSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(humidityImageView)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(gradusesLabel)
    }
    
    private func setupLayoutsMain() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            
            humidityImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4.0),
            humidityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -2.0),
            humidityImageView.widthAnchor.constraint(equalToConstant: 40),
            humidityImageView.heightAnchor.constraint(equalToConstant: 20),
    
            humidityLabel.centerYAnchor.constraint(equalTo: humidityImageView.centerYAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: -10.0),
            
            conditionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70.0),
            conditionLabel.trailingAnchor.constraint(equalTo: gradusesLabel.leadingAnchor, constant: 8.0),
            
            gradusesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gradusesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            
            contentView.bottomAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8.0)
        ])
    }

    
    //MARK: - Actions

    
    // MARK: - Public
    
    func setup(with model: CityWeatherForecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateLabel.text = dateFormatter.string(from: model.date)
        
        humidityLabel.text = "\(model.avgHumidity)%"
        conditionLabel.text = model.conditionText
        gradusesLabel.text = "\(Int(model.getAvarageTemp().0))°-\(Int(model.getAvarageTemp().1))°"
    }
}
