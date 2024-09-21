//
//  SettingsStore.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import Foundation

final class SettingsStore {
    static let shared = SettingsStore()
    
    private init() {}
    
    func isFirstRun() -> Bool {
        /*
         0 - первый запуск
         1 - авто локация
         2 - ручная локация
         */
        let defaults = UserDefaults.standard
        let a = defaults.integer(forKey: "autoLocation")

        return a == 0 ? true : false
    }
    
    func isAutoLocation() -> Bool {
        let defaults = UserDefaults.standard
        let a = defaults.integer(forKey: "autoLocation")
        
        return a == 1 ? true : false
    }
    
    func setAutoLocation() {
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: "autoLocation")
    }
    
    func setManualLocation() {
        let defaults = UserDefaults.standard
        defaults.set(2, forKey: "autoLocation")
    }
    
    func setTempMetricMode(value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "tempMode")
    }
    
    /// Если true -> F else C
    func getTempMetricMode() -> Bool {
        let defaults = UserDefaults.standard
        let a = defaults.integer(forKey: "tempMode")
        
        return a == 1 ? true : false
    }
    
    func setWindMetricMode(value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "windMode")
    }
    
    // Если true -> mi else km
    func getWindMetricMode() -> Bool {
        let defaults = UserDefaults.standard
        let a = defaults.integer(forKey: "windMode")
        
        return a == 1 ? true : false
    }
    
    func getWindSpeedEnding() -> String {
        if getWindMetricMode() {
            return "м/с"
        } else {
            return "км/ч"
        }
    }
    
    func getTempEnding() -> String {
        if getTempMetricMode() {
            return "°F"
        } else {
            return "°C"
        }
    }
    
    func get24Time(from time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let date = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HH:mm"

        let normTime = dateFormatter.string(from: date!)
        
        return normTime
    }
}
