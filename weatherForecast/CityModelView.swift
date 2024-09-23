//
//  CityModelView.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//
import Foundation

class CityModelView {
    let lat: Double
    let lon: Double

    var citeWeather: CityWeather?
    var cityWeatherForecast: [CityWeatherForecast] = []
    
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
            citeWeather = savedCity
            
            state = .loadedSaved
        }
        
        fetchWeatherData()
    }
    
    private func fetchWeatherData( ) {
        NetworkManager.shared.fetchWeatherData(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let current):
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = .gmt
                dateFormatter.dateFormat = "h:mm a"
                
                let sunrise = dateFormatter.date(from: (current.forecast.foreCastByDay.first?.astro.sunrise)!)
                let sunset = dateFormatter.date(from: (current.forecast.foreCastByDay.first?.astro.sunset)!)
                let moonrise = dateFormatter.date(from: (current.forecast.foreCastByDay.first?.astro.moonrise)!)
                let moonset = dateFormatter.date(from: (current.forecast.foreCastByDay.first?.astro.moonset)!)
                
                var byHour: [CityWeatherByHour] = []
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                
                current.forecast.foreCastByDay.first?.hour.forEach { time in
                    let hour = CityWeatherByHour(
                        tempC: time.tempC,
                        tempF: time.tempF,
                        time: (dateFormatter.date(from: time.time))!,
                        conditionText: time.condition.text
                    )
                    
                    byHour.append(hour)
                }
                
                let ftch = CityWeather(
                    lat: current.location.lat,
                    lon: current.location.lon,
                    name: current.location.name,
                    tempC: current.current.tempC,
                    tempF: current.current.tempF,
                    feelsLikeC: current.current.feelsLikeC,
                    feelsLikeF: current.current.feelsLikeF,
                    windM: current.current.windM,
                    windKm: current.current.windKm,
                    humidity: current.current.humidity,
                    cloud: current.current.cloud,
                    conditionText: current.current.condition.text,
                    sunrise: sunrise!,
                    sunset: sunset!,
                    moonrise: moonrise!,
                    moonset: moonset!,
                    byHour: byHour
                )
                
                self.citeWeather = ftch
                
                current.forecast.foreCastByDay.forEach { day in
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: day.date)
                    
                    let forecast = CityWeatherForecast(
                        date: date!,
                        minTempC: day.day.minTempC,
                        maxTempC: day.day.maxTempC,
                        minTempF: day.day.minTempF,
                        maxTempF: day.day.maxTempF,
                        avgHumidity: day.day.avgHumidity,
                        windSpeedM: day.day.windSpeedM,
                        windSpeedK: day.day.windSpeedK,
                        conditionText: day.day.condition.text,
                        rainChance: day.day.rainChance
                    )
                    
                    self.cityWeatherForecast.append(forecast)
                }
                
                
                self.state = .loaded
                
                CoreDataManager.shared.updateCurrent(city: ftch)
                
            case .failure:
                self.state = .error
            }
        }
    }
}
