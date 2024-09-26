//
//  MoreDaySunTableVIew.swift
//  weatherForecast
//
//  Created by eva on 21.09.2024.
//
import UIKit

class MoreDaySunTableView: UITableViewCell {
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.text = "Солнце и Луна"
        
        return label
    }()
    
    private lazy var sunImage: UIImageView = {
        let image = UIImageView(image: .sun)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        label.text = "Восход"
        
        return label
    }()
    
    private lazy var sunriseValue: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        
        return label
    }()

    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        label.text = "Заход"
        
        return label
    }()
    
    private lazy var sunsetValue: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        
        return label
    }()


    private lazy var moonImage: UIImageView = {
        let image = UIImageView(image: .moon)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var moonriseLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        label.text = "Восход"
        
        return label
    }()
    
    private lazy var moonriseValue: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var moonsetLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .gray
        label.text = "Заход"
        
        return label
    }()
    
    private lazy var moonsetValue: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        
        return label
    }()

    private lazy var sunView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var moonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var splitView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        
        stackView.axis = .horizontal
        
        stackView.addArrangedSubview(sunView)
        sunView.addSubview(sunImage)
        sunView.addSubview(sunriseLabel)
        sunView.addSubview(sunriseValue)
        sunView.addSubview(sunsetLabel)
        sunView.addSubview(sunsetValue)
        
        stackView.addSubview(splitView)
        
        stackView.addArrangedSubview(moonView)
        moonView.addSubview(moonImage)
        moonView.addSubview(moonriseLabel)
        moonView.addSubview(moonriseValue)
        moonView.addSubview(moonsetLabel)
        moonView.addSubview(moonsetValue)
        
        return stackView
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
        contentView.backgroundColor = .clear
        
        setupSubviews()
        
        setupLayoutsMain()
    }

    // MARK: - Private
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
    }
    
    private func setupLayoutsMain() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackView.heightAnchor.constraint(equalToConstant: 100.0),
            
            sunView.topAnchor.constraint(equalTo: stackView.topAnchor),
            sunView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            sunView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            sunView.trailingAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            moonView.topAnchor.constraint(equalTo: stackView.topAnchor),
            moonView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            moonView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            moonView.leadingAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            splitView.topAnchor.constraint(equalTo: stackView.topAnchor),
            splitView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            splitView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            splitView.widthAnchor.constraint(equalToConstant: 1.0),
            
            //SUN
            sunImage.topAnchor.constraint(equalTo: sunView.topAnchor),
            sunImage.centerXAnchor.constraint(equalTo: sunView.centerXAnchor),
            sunImage.widthAnchor.constraint(equalToConstant: 17),
            sunImage.heightAnchor.constraint(equalToConstant: 17),
            
            sunriseLabel.topAnchor.constraint(equalTo: sunImage.bottomAnchor, constant: 8.0),
            sunriseLabel.leadingAnchor.constraint(equalTo: sunView.leadingAnchor, constant: 16.0),
            
            sunriseValue.topAnchor.constraint(equalTo: sunriseLabel.topAnchor),
            sunriseValue.trailingAnchor.constraint(equalTo: sunView.trailingAnchor, constant: -10.0),
            
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 8.0),
            sunsetLabel.leadingAnchor.constraint(equalTo: sunriseLabel.leadingAnchor),
            
            sunsetValue.topAnchor.constraint(equalTo: sunsetLabel.topAnchor),
            sunsetValue.trailingAnchor.constraint(equalTo: sunView.trailingAnchor, constant: -10.0),
            
            //MOON
            moonImage.topAnchor.constraint(equalTo: moonView.topAnchor),
            moonImage.centerXAnchor.constraint(equalTo: moonView.centerXAnchor),
            moonImage.widthAnchor.constraint(equalToConstant: 17),
            moonImage.heightAnchor.constraint(equalToConstant: 17),

            moonriseLabel.topAnchor.constraint(equalTo: moonImage.bottomAnchor, constant: 8.0),
            moonriseLabel.leadingAnchor.constraint(equalTo: moonView.leadingAnchor, constant: 16.0),
            
            moonriseValue.topAnchor.constraint(equalTo: moonriseLabel.topAnchor),
            moonriseValue.trailingAnchor.constraint(equalTo: moonView.trailingAnchor, constant: -10.0),
            
            moonsetLabel.topAnchor.constraint(equalTo: moonriseLabel.bottomAnchor, constant: 8.0),
            moonsetLabel.leadingAnchor.constraint(equalTo: moonriseLabel.leadingAnchor),
            
            moonsetValue.topAnchor.constraint(equalTo: moonsetLabel.topAnchor),
            moonsetValue.trailingAnchor.constraint(equalTo: moonView.trailingAnchor, constant: -10.0),
        
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.0)
        ])
    }
    
    // MARK: Public
    
    func setup(with model: CityWeather) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "HH:mm"
        
        if let sunrise = model.sunrise {
            sunriseValue.text = dateFormatter.string(from: sunrise)
        } else {
            sunriseValue.text = "-"
        }
        
        if let sunset = model.sunset {
            sunsetValue.text = dateFormatter.string(from: sunset)
        } else {
            sunsetValue.text = "-"
        }
        
        if let moonrise = model.moonrise {
            moonriseValue.text = dateFormatter.string(from: moonrise)
        } else {
            moonriseValue.text = "-"
        }
        
        if let moonset = model.moonset {
            moonsetValue.text = dateFormatter.string(from: moonset)
        } else {
            moonsetValue.text = "-"
        }
    }
}
