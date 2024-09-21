//
//  EmptyContentViewController.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import UIKit

class EmptyContentViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var addGeoImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "plus"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        
        image.isHidden = true
        
//        image.isUserInteractionEnabled = true
        
//        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(vehicleIconLongPress(_ :)))
//        image.addGestureRecognizer(longTap)
//
//        editMenuInteraction = UIEditMenuInteraction(delegate: self)
//        image.addInteraction(editMenuInteraction!)
    
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
    
}
