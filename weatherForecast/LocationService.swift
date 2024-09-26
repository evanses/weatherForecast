//
//  LocationService.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import CoreLocation

final class LocationService {
    static let shared = LocationService()
    
    private init() {}

    func getCurrentLocation() -> (Double, Double) {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        let currentLocation: CLLocation! = locManager.location
        
        guard let currentLocation else {
            return (0, 0)
        }

        return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
    }
    
    func autorize() {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
    }
}
