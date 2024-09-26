//
//  SettingsStore.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import Foundation

final class SettingsStore {
    static let shared = SettingsStore()
    private let defaults = UserDefaults.standard
    
    var metricWindMode: Bool {
        get {
            defaults.bool(forKey: "windMode")
        }
        set {
            defaults.set(newValue, forKey: "windMode")
        }
    }
    
    var metricTempMode: Bool {
        get {
            defaults.bool(forKey: "tempMode")
        }
        set {
            defaults.set(newValue, forKey: "tempMode")
        }
    }
    
    private init() {}
    
    func isFirstRun() -> Bool {
        /*
         0 - первый запуск
         1 - авто локация
         2 - ручная локация
         */
        let a = defaults.integer(forKey: "autoLocation")

        return a == 0 ? true : false
    }
    
    func isAutoLocation() -> Bool {
        let a = defaults.integer(forKey: "autoLocation")
        
        return a == 1 ? true : false
    }
    
    func setAutoLocation() {
        defaults.set(1, forKey: "autoLocation")
    }
    
    func setManualLocation() {
        defaults.set(2, forKey: "autoLocation")
    }
    
    func getWindSpeedEnding() -> String {
        if metricWindMode {
            return "м/с"
        } else {
            return "км/ч"
        }
    }
    
    func getTempEnding() -> String {
        if metricTempMode {
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
