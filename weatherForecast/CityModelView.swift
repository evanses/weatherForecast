//
//  CityModelView.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

class CityModelView {
    let lat: Double
    let lon: Double
    
    var cityModel: CityModel?
    
    enum State {
        case initing
        case loadedSaved
        case loaded
        case error
    }
    
    var stateChanger: ((State) -> Void)?
    
    private var state: State = .initing {
        didSet {
            stateChanger?(state)
        }
    }
    
    init (lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        
        let savedCity = CoreDataManager.shared.getCurrent()
        
        if let savedCity {
            cityModel = savedCity
            
            state = .loadedSaved
        }
        
        fetchWeatherData()
    }
    
    private func fetchWeatherData( ) {
        NetworkManager.shared.fetchWeatherData(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.cityModel = model
                
                self.state = .loaded
                
                CoreDataManager.shared.updateCurrent(city: model)
                
            case .failure:
                self.state = .error
            }
        }
    }
}
