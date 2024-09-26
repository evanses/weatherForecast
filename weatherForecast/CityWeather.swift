//
//  CityWeather.swift
//  weatherForecast
//
//  Created by eva on 22.09.2024.
//

import Foundation

struct CityWeather {
    let lat: Double
    let lon: Double
    let name: String
    
    let tempC: Double
    let tempF: Double
    
    let feelsLikeC: Double
    let feelsLikeF: Double
    
    let windM: Double
    let windKm: Double
    
    let humidity: Int
    
    let cloud: Int
    
    let conditionText: String
    
    let sunrise: Date?
    let sunset: Date?
    let moonrise: Date?
    let moonset: Date?
    
    let byHour: [CityWeatherByHour]
    
    func getTemp() -> Double {
        if SettingsStore.shared.getTempMetricMode() {
            return tempF
        } else {
            return tempC
        }
    }
    
    func getFeelsLikeTemp() -> Double {
        if SettingsStore.shared.getTempMetricMode() {
            return feelsLikeF
        } else {
            return feelsLikeC
        }
    }
    
    func getWindSpeed() -> Double {
        if SettingsStore.shared.getWindMetricMode() {
            return windM
        } else {
            return windKm
        }
    }
}

struct CityWeatherForecast {
    let date: Date

    let minTempC: Double
    let maxTempC: Double
    
    let minTempF: Double
    let maxTempF: Double
    
    let avgHumidity: Int
    
    let windSpeedM: Double
    let windSpeedK: Double
    
    let conditionText: String
    
    let rainChance: Int
    
    func getAvarageTemp() -> (Double, Double) {
        if SettingsStore.shared.getTempMetricMode() {
            return (minTempF, maxTempF)
        } else {
            return (minTempC, maxTempC)
        }
    }
    
    func getWindSpeed() -> Double {
        if SettingsStore.shared.getTempMetricMode() {
            return windSpeedM
        } else {
            return windSpeedK
        }
    }
}

struct CityWeatherByHour {
    let tempC: Double
    let tempF: Double
    let time: Date

    let conditionText: String
    
    func getTemp() -> Double {
        if SettingsStore.shared.getTempMetricMode() {
            return tempF
        } else {
            return tempC
        }
    }
}
