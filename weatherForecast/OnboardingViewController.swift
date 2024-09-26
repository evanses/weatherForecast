//
//  OnboardingViewController.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import UIKit
import CoreLocation

class OnboardingViewController: UIViewController {
    
    // MARK: Data
    
    private var locationManager: CLLocationManager?
    
    // MARK: Subviews
    
    private lazy var errorAlertView: UIAlertController = {
        let newAlertController = UIAlertController(
            title: "Видимо Вы запретили доступ к геопозиции",
            message: "В таком случае добавлять локации нужно будет вручную",
            preferredStyle: .alert
        )
        
        newAlertController.addAction(UIAlertAction(
            title: "Ок",
            style: .default,
            handler: { action in
                SettingsStore.shared.setManualLocation()
                self.dismiss(animated: true)
            }
        ))

        return newAlertController
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView(image: .onboarding)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        label.text = "Разрешить приложению использовать данные о местоположении Вашего устройства?"
        
        return label
    }()
    
    private lazy var title2Label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        
        return label
    }()
    
    private lazy var title3Label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        label.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        
        return label
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)

        button.backgroundColor = .orangeButton
        return button
    }()
    
    private lazy var declineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main
        
        addSubviews()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(mainImage)
        view.addSubview(titleLabel)
        view.addSubview(title2Label)
        view.addSubview(title3Label)
        view.addSubview(acceptButton)
        view.addSubview(declineButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            mainImage.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            mainImage.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 60.0),
            mainImage.widthAnchor.constraint(equalToConstant: 160),
            mainImage.heightAnchor.constraint(equalToConstant: 176.0),
            
            titleLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 40.0),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),

            title2Label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0),
            title2Label.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            title2Label.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),

            title3Label.topAnchor.constraint(equalTo: title2Label.bottomAnchor, constant: 10.0),
            title3Label.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            title3Label.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),

            
            acceptButton.topAnchor.constraint(equalTo: title3Label.bottomAnchor, constant: 60.0),
            acceptButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            acceptButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            
            declineButton.topAnchor.constraint(equalTo: acceptButton.bottomAnchor, constant: 10.0),
            declineButton.trailingAnchor.constraint(equalTo: acceptButton.trailingAnchor)
        ])
    }
    
    private func setupActions() {
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(declineButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc private func acceptButtonPressed() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    @objc private func declineButtonPressed() {
        SettingsStore.shared.setManualLocation()
        dismiss(animated: true)
    }
}

extension OnboardingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.last {
            locationManager?.stopUpdatingLocation()
            SettingsStore.shared.setAutoLocation()
            dismiss(animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        present(errorAlertView, animated: true)
    }
}
