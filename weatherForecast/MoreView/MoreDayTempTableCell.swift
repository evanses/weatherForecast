//
//  MoreDayTempTableCell.swift
//  weatherForecast
//
//  Created by eva on 20.09.2024.
//

import UIKit

class MoreDayTempTableCell: UITableViewCell {
    
    // MARK: Data
    
    enum Mode: Int {
        case day = 0
        case night = 1
    }
    
    // MARK: - Subviews
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.text = "День"
        
        return label
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        
        return label
    }()

    private lazy var windLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.text = "Ветер"
        
        return label
    }()
    
    private lazy var windSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        
        return label
    }()

    
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.text = "Дождь"
        
        return label
    }()
    
    private lazy var rainSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rainValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        
        return label
    }()

    private lazy var сloudLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.text = "Влажность"
        
        return label
    }()
    
    private lazy var cloudSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cloudValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        
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
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10.0
        contentView.backgroundColor = .tableCell
        
        setupSubviews()
        
        setupLayoutsMain()
    }

    // MARK: - Private
    
    private func setupSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(degreesLabel)
        contentView.addSubview(conditionLabel)
        
        contentView.addSubview(windLabel)
        contentView.addSubview(windSpace)
        contentView.addSubview(windValueLabel)
        
        contentView.addSubview(rainLabel)
        contentView.addSubview(rainSpace)
        contentView.addSubview(rainValueLabel)
        
        contentView.addSubview(сloudLabel)
        contentView.addSubview(cloudSpace)
        contentView.addSubview(cloudValueLabel)
    }
    
    private func setupLayoutsMain() {
        let spaceHeight: CGFloat = 0.5
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            degreesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            degreesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            conditionLabel.topAnchor.constraint(equalTo: degreesLabel.bottomAnchor, constant: 8.0),
            conditionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            
            windLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 8.0),
            windLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            windSpace.heightAnchor.constraint(equalToConstant: spaceHeight),
            windSpace.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 8.0),
            windSpace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            windSpace.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            windSpace.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            windValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            windValueLabel.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),

            
            rainLabel.topAnchor.constraint(equalTo: windSpace.bottomAnchor, constant: 8.0),
            rainLabel.leadingAnchor.constraint(equalTo: windLabel.leadingAnchor),
            
            rainSpace.heightAnchor.constraint(equalToConstant: spaceHeight),
            rainSpace.topAnchor.constraint(equalTo: rainLabel.bottomAnchor, constant: 8.0),
            rainSpace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rainSpace.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rainSpace.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            rainValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            rainValueLabel.centerYAnchor.constraint(equalTo: rainLabel.centerYAnchor),
            
            
            сloudLabel.topAnchor.constraint(equalTo: rainSpace.bottomAnchor, constant: 8.0),
            сloudLabel.leadingAnchor.constraint(equalTo: rainLabel.leadingAnchor),
            
            cloudSpace.heightAnchor.constraint(equalToConstant: spaceHeight),
            cloudSpace.topAnchor.constraint(equalTo: сloudLabel.bottomAnchor, constant: 8.0),
            cloudSpace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cloudSpace.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cloudSpace.widthAnchor.constraint(equalTo: contentView.widthAnchor),

            cloudValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            cloudValueLabel.centerYAnchor.constraint(equalTo: сloudLabel.centerYAnchor),
            
            
            contentView.bottomAnchor.constraint(equalTo: cloudSpace.bottomAnchor, constant: 16.0)
        ])
    }
    
    // MARK: Public
    
    func setupView(mode: Mode, model: CityModelForecastByDay) {
        if mode == .day {
            dayLabel.text = "День"
            
            degreesLabel.text = "\(model.day.getAvarageTemp().1) \(SettingsStore.shared.getTempEnding())"
            
        } else {
            dayLabel.text = "Ночь"
            
            degreesLabel.text = "\(model.day.getAvarageTemp().0) \(SettingsStore.shared.getTempEnding())"
        }
        
        conditionLabel.text = model.day.condition.text
        windValueLabel.text = "\(model.day.getWindSpeed()) \(SettingsStore.shared.getWindSpeedEnding())"
        rainValueLabel.text = "\(model.day.rainChance)%"
        cloudValueLabel.text = "\(model.day.avgHumidity)%"
    }
}
