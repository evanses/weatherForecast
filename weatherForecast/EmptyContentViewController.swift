//
//  EmptyContentViewController.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import UIKit

class EmptyContentViewController: UIViewController {
    
    // MARK: Data
    
    var delegate: PageViewControllerDelegate?
    
    // MARK: Subviews
    
    private lazy var addGeoImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "plus"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        
        image.isHidden = true
        
        image.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(addNewCity)
        )
        tap.numberOfTapsRequired = 1
        image.addGestureRecognizer(tap)
        return image
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addGeoImage.isHidden = false
        
        view.addSubview(addGeoImage)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate( [
            addGeoImage.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            addGeoImage.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            addGeoImage.widthAnchor.constraint(equalToConstant: 100),
            addGeoImage.heightAnchor.constraint(equalToConstant: 100)
        ])

    }
    
    // MARK: Private
    
    
    // MARK: Action
    
    @objc private func addNewCity() {
        AddCityAlertView.picker.show(in: self) { cityName in
            NetworkManager.shared.geoCoding(cityName: cityName) { result in
                switch result {
                case .success(let success):
                    CoreDataManager.shared.addCity(newCity: success)
                    
                    DispatchQueue.main.async {
                        AlertView.alert.show(in: self, text: "Город добавлен!")
                        
                        guard let lat = Double(success.lat), let lon = Double(success.lon) else { return }
                        
                        let newPage = ContentCurrentViewController(
                            lat: lat,
                            lon: lon
                        )
                        
                        self.delegate?.appendToPages(newPage)
                    }
                case .failure(let __error):
                    DispatchQueue.main.async {
                        AlertView.alert.show(in: self, text: "Ошибка, попробуйте еще раз!")
                    }
                }
            }
        }
    }
    
}
