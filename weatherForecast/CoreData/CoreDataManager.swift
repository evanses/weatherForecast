//
//  CoreDataManager.swift
//  weatherForecast
//
//  Created by eva on 21.09.2024.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "weatherForecast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    func getCurrent() -> CityWeather? {
        let req = SavedCurrent.fetchRequest()
        let ftch = (try? persistentContainer.viewContext.fetch(req)) ?? []
        
        var savedList: [CityWeather] = []
        
        ftch.forEach { city in
            guard let cityName = city.cityName, let conditionText = city.conditionText else {
                return
            }
            
            let cityWeather = CityWeather(
                lat: city.lat,
                lon: city.lon,
                name: cityName,
                tempC: city.tempC,
                tempF: city.tempF,
                feelsLikeC: city.feelsLikeC,
                feelsLikeF: city.feelsLikeF,
                windM: city.windM,
                windKm: city.windKm,
                humidity: Int(city.humidity),
                cloud: Int(city.cloud),
                conditionText: conditionText,
                sunrise: Date(),
                sunset: Date(),
                moonrise: Date(),
                moonset: Date(),
                byHour: []
            )
            
            savedList.append(cityWeather)
        }
        
        return savedList.first
    }

    func updateCurrent(city: CityWeather) {
        persistentContainer.performBackgroundTask { backContext in
            let req = SavedCurrent.fetchRequest()
            let ftch = (try? backContext.fetch(req)) ?? []
            ftch.forEach { city in
                let toDelete = backContext.object(with: city.objectID)
                backContext.delete(toDelete)
                try? backContext.save()
            }
            
            let toSaveCity = SavedCurrent(context: backContext)
            toSaveCity.cityName = city.name
            toSaveCity.lat = city.lat
            toSaveCity.lon = city.lon
            toSaveCity.tempC = city.tempC
            toSaveCity.feelsLikeC = city.feelsLikeC
            toSaveCity.tempF = city.tempF
            toSaveCity.feelsLikeF = city.feelsLikeF
            toSaveCity.windM = city.windM
            toSaveCity.windKm = city.windKm
            toSaveCity.humidity = Int64(city.humidity)
            toSaveCity.cloud = Int64(city.cloud)
            toSaveCity.conditionText = city.conditionText
            
            try? backContext.save()
        }
    }

    func addCity(newCity: GeoCodingCity) {
        guard let lat: Double = Double(newCity.lat), let lon: Double = Double(newCity.lon) else {
            return
        }
        
        persistentContainer.performBackgroundTask { backContext in
            let toSaveCity = SavedCity(context: backContext)
            toSaveCity.lat = lat
            toSaveCity.lon = lon
            
            try? backContext.save()
        }
    }
    
    func getCities() -> [(Double, Double)] {
        let req = SavedCity.fetchRequest()
        let ftch = (try? persistentContainer.viewContext.fetch(req)) ?? []
        
        var savedList: [(Double, Double)] = []
        
        ftch.forEach { city in
            
            savedList.append((city.lat, city.lon))
        }
        
        return savedList
    }
}
