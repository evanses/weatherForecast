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

    func getCurrent() -> CityModel? {
        let req = SavedCurrent.fetchRequest()
        let ftch = (try? persistentContainer.viewContext.fetch(req)) ?? []
        
        var savedList: [CityModel] = []
        
        ftch.forEach { city in
            guard let cityName = city.cityName, let conditionText = city.conditionText else {
                return
            }
            
            let location = CityModelLocation(
                name: cityName,
                lat: city.lat,
                lon: city.lon
            )
            
            let current = CityModelCurrentWeather(
                tempC: city.tempC,
                feelsLikeC: city.feelsLikeC,
                tempF: city.tempF,
                feelsLikeF: city.feelsLikeF,
                windM: city.windM,
                windKm: city.windKm,
                humidity: Int(city.humidity),
                cloud: Int(city.cloud),
                condition: CityModelCondition(text: conditionText)
            )
            
            let forecast = CityModelForecast(foreCastByDay: [])
            
            let saveCity = CityModel(
                location: location,
                current: current,
                forecast: forecast
            )
            
            savedList.append(saveCity)
        }
        
        return savedList.first
    }

    func updateCurrent(city: CityModel) {        
        persistentContainer.performBackgroundTask { backContext in
            let req = SavedCurrent.fetchRequest()
            let ftch = (try? backContext.fetch(req)) ?? []
            ftch.forEach { city in
                let toDelete = backContext.object(with: city.objectID)
                backContext.delete(toDelete)
                try? backContext.save()
            }
            
            let toSaveCity = SavedCurrent(context: backContext)
            toSaveCity.cityName = city.location.name
            toSaveCity.lat = city.location.lat
            toSaveCity.lon = city.location.lon
            toSaveCity.tempC = city.current.tempC
            toSaveCity.feelsLikeC = city.current.feelsLikeC
            toSaveCity.tempF = city.current.tempF
            toSaveCity.feelsLikeF = city.current.feelsLikeF
            toSaveCity.windM = city.current.windM
            toSaveCity.windKm = city.current.windKm
            toSaveCity.humidity = Int64(city.current.humidity)
            toSaveCity.cloud = Int64(city.current.cloud)
            toSaveCity.conditionText = city.current.condition.text
            
            try? backContext.save()
        }
    }

    
}
