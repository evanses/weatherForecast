//
//  ContentCurrentViewController.swift
//  weatherForecast
//
//  Created by eva on 15.09.2024.
//

import Foundation
import UIKit

class ContentCurrentViewController: UIViewController {
    
    // MARK: Data
    
    let model: CityModelView
    
    private enum ReuseID: String {
        case collection = "HourForecaseCell_ReuseID"
        case table = "TableViewCell_ReuseID"
    }
    
    // MARK: Subviews
    
    private lazy var cityTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        label.text = "Обновление..."
        
        return label
    }()
    
    // MARK: -- Header
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 6
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var sunriseImageView: UIImageView = {
        let image = UIImageView(image: .sunrise)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var sunsetImageView: UIImageView = {
        let image = UIImageView(image: .sunset)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var gradusLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        
        return label
    }()
    
    private lazy var feelingLikeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var cloudImageView: UIImageView = {
        let image = UIImageView(image: .cloud)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var cloudImageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var windImageView: UIImageView = {
        let image = UIImageView(image: .wind)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var windImageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()

    
    private lazy var humidityImageView: UIImageView = {
        let image = UIImageView(image: .humidity)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var humidityImageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    // MARK: -- 24 часа
    
    private lazy var showMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подробнее на 24 часа", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: -- Hour forecast
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(
            HourForecastCollectionCell.self,
            forCellWithReuseIdentifier: ReuseID.collection.rawValue
        )
        
        return collectionView
    }()
    
    // MARK: -- Ежедневный прогноз
    
    private lazy var everydayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Ежедневный прогноз"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()

    private lazy var everydayForecastTable: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()

    
    // MARK: Lifecycle
    
    init(lat: Double, lon: Double) {
        model = CityModelView(lat: lat, lon: lon)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubviews()
        setupConstraints()
        
        bindingModelView()
        
        tuneTableView()
        tuneColletionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    // MARK: - Private
    
    func updateView() {
        if let cityModel = model.citeWeather {
            cityTitleLabel.text = cityModel.name
            
            gradusLabel.text = "\(cityModel.getTemp()) \(SettingsStore.shared.getTempEnding())"
            feelingLikeLabel.text = "Ощущается как \(cityModel.getFeelsLikeTemp()) \(SettingsStore.shared.getTempEnding())"
            conditionLabel.text = cityModel.conditionText
            cloudImageLabel.text = "\(cityModel.cloud)"
            windImageLabel.text = "\(cityModel.getWindSpeed()) \(SettingsStore.shared.getWindSpeedEnding())"
            humidityImageLabel.text = "\(cityModel.humidity)%"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            if let sunrise = cityModel.sunrise {
                sunriseLabel.text = dateFormatter.string(from: sunrise)
            } else {
                sunriseLabel.text = "-"
            }
            
            if let sunset = cityModel.sunset {
                sunsetLabel.text = dateFormatter.string(from: sunset)
            } else {
                sunsetLabel.text = "-"
            }
            
            collectionView.reloadData()
            everydayForecastTable.reloadData()
        }
    }

    func setupViewFromSaved() {
        if let cityModel = model.citeWeather {
            cityTitleLabel.text = cityModel.name
            
            gradusLabel.text = "\(cityModel.getTemp()) \(SettingsStore.shared.getTempEnding())"
            feelingLikeLabel.text = "Ощущается как \(cityModel.getFeelsLikeTemp()) \(SettingsStore.shared.getTempEnding())"
            conditionLabel.text = cityModel.conditionText
            cloudImageLabel.text = "\(cityModel.cloud)"
            windImageLabel.text = "\(cityModel.getWindSpeed()) \(SettingsStore.shared.getWindSpeedEnding())"
            humidityImageLabel.text = "\(cityModel.humidity)%"
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .gmt
            dateFormatter.dateFormat = "HH:mm"
            
            if let sunrise = cityModel.sunrise {
                sunriseLabel.text = dateFormatter.string(from: sunrise)
            } else {
                sunriseLabel.text = "-"
            }
            
            if let sunset = cityModel.sunset {
                sunsetLabel.text = dateFormatter.string(from: sunset)
            } else {
                sunsetLabel.text = "-"
            }
        }
    }
    
    private func bindingModelView() {
        model.stateChanger = { [weak self] state in
            guard let self else { return }
            
            switch state {
            case .initing:
                break
            case .loaded:
                DispatchQueue.main.async {
                    self.updateView()
                }
            case .loadedSaved:
                DispatchQueue.main.async {
                    self.setupViewFromSaved()
                    print("check")
                }

            case .error:
                DispatchQueue.main.async {
                    self.cityTitleLabel.text = "Ошибка обновления!"
                }
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(cityTitleLabel)
        
        view.addSubview(headerView)
        
        headerView.addSubview(sunriseImageView)
        headerView.addSubview(sunriseLabel)
    
        headerView.addSubview(sunsetImageView)
        headerView.addSubview(sunsetLabel)
        
        headerView.addSubview(gradusLabel)
        headerView.addSubview(feelingLikeLabel)
        headerView.addSubview(conditionLabel)
        
        headerView.addSubview(cloudImageView)
        headerView.addSubview(cloudImageLabel
        )
        headerView.addSubview(windImageView)
        headerView.addSubview(windImageLabel)
        
        headerView.addSubview(humidityImageView)
        headerView.addSubview(humidityImageLabel)
        
        view.addSubview(showMoreButton)
        
        view.addSubview(collectionView)
        
        view.addSubview(everydayLabel)
        view.addSubview(everydayForecastTable)
    }
    
    private func tuneColletionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            cityTitleLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 5.0),
            cityTitleLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            cityTitleLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            
            // Header
            headerView.topAnchor.constraint(equalTo: cityTitleLabel.bottomAnchor, constant: 8.0),
            headerView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            headerView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            
            // Sunrise
            sunriseLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            sunriseLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8.0),
            
            sunriseImageView.bottomAnchor.constraint(equalTo: sunriseLabel.topAnchor, constant: -4.0),
            sunriseImageView.centerXAnchor.constraint(equalTo: sunriseLabel.centerXAnchor),
            sunriseImageView.widthAnchor.constraint(equalToConstant: 17),
            sunriseImageView.heightAnchor.constraint(equalToConstant: 17),
            
            // Sunset
            sunsetLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            sunsetLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8.0),

            sunsetImageView.bottomAnchor.constraint(equalTo: sunsetLabel.topAnchor, constant: -4.0),
            sunsetImageView.centerXAnchor.constraint(equalTo: sunsetLabel.centerXAnchor),
            sunsetImageView.widthAnchor.constraint(equalToConstant: 17),
            sunsetImageView.heightAnchor.constraint(equalToConstant: 17),

            
            gradusLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8.0),
            gradusLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            
            feelingLikeLabel.topAnchor.constraint(equalTo: gradusLabel.bottomAnchor, constant: 2.0),
            feelingLikeLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
    
            conditionLabel.topAnchor.constraint(equalTo: feelingLikeLabel.bottomAnchor, constant: 16.0),
            conditionLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            
            windImageView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 16.0),
            windImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -20.0),
            windImageView.widthAnchor.constraint(equalToConstant: 40),
            windImageView.heightAnchor.constraint(equalToConstant: 20),
            
            windImageLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            windImageLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 2.0),
            
            cloudImageView.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            cloudImageView.trailingAnchor.constraint(equalTo: windImageView.leadingAnchor, constant: -50.0),
            cloudImageView.widthAnchor.constraint(equalToConstant: 40),
            cloudImageView.heightAnchor.constraint(equalToConstant: 20),
            
            cloudImageLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            cloudImageLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 2.0),
            
            humidityImageView.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            humidityImageView.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 50.0),
            humidityImageView.widthAnchor.constraint(equalToConstant: 40),
            humidityImageView.heightAnchor.constraint(equalToConstant: 20),
            
            humidityImageLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
            humidityImageLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 2.0),
            
            
            headerView.bottomAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 16.0),
            
            
            showMoreButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16.0),
            showMoreButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            
            
            collectionView.topAnchor.constraint(equalTo: showMoreButton.bottomAnchor, constant: -8.0),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
    
            everydayLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            everydayLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            
            everydayForecastTable.topAnchor.constraint(equalTo: everydayLabel.bottomAnchor, constant: 8.0),
            everydayForecastTable.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            everydayForecastTable.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            everydayForecastTable.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        everydayForecastTable.estimatedRowHeight = 70.0
        everydayForecastTable.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            everydayForecastTable.sectionHeaderTopPadding = 0.0
        }
         
        everydayForecastTable.tableHeaderView = UIView(frame: .zero)
        everydayForecastTable.tableFooterView = UIView(frame: .zero)
        
        everydayForecastTable.register(
            EverydayTableCell.self,
            forCellReuseIdentifier: ReuseID.table.rawValue
        )
        
        everydayForecastTable.dataSource = self
        everydayForecastTable.delegate = self
        
        everydayForecastTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        everydayForecastTable.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }

    
    // MARK: Action
    
    // MARK: Public
    
}

// MARK: UICollectionViewDataSource

extension ContentCurrentViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        model.citeWeather?.byHour.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReuseID.collection.rawValue,
            for: indexPath) as! HourForecastCollectionCell
        
        guard let i = model.citeWeather?.byHour[indexPath.row] else { return cell }
        
        cell.setup(with: i)

        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ContentCurrentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Did select cell at \(indexPath.row)")
    }
}

// MARK: UITableViewDataSource

extension ContentCurrentViewController: UITableViewDataSource {
    
    // Не разобрался как сделать отступы между ячейка. Зато придумал как это сделать через секции и вью как футер каждой :)
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.cityWeatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = everydayForecastTable.dequeueReusableCell(
            withIdentifier: ReuseID.table.rawValue,
            for: indexPath
        ) as? EverydayTableCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        let i = model.cityWeatherForecast[indexPath.section]
        cell.setup(with: i)
        return cell
    }
}

// MARK: UITableViewDelegate

extension ContentCurrentViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let citeWeather = model.citeWeather else { return }
        let i = model.cityWeatherForecast[indexPath.section]
        
        let nextVC = MoreForecastViewController(
            cityModel: citeWeather,
            forecastModel: i
        )
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
