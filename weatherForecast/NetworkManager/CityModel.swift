//
//  CityModel.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import Foundation

/*
 {
 "location": {
     "name": "Тюмень",
     "region": "Tyumen'",
     "country": "Russia",
     "lat": 57.11,
     "lon": 65.57,
     "tz_id": "Asia/Yekaterinburg",
     "localtime_epoch": 1726757786,
     "localtime": "2024-09-19 19:56"
 },
 "current": {
     "last_updated_epoch": 1726757100,
     "last_updated": "2024-09-19 19:45",
     "temp_c": 15.3,
     "temp_f": 59.5,
     "is_day": 0,
     "condition": {
         "text": "В отдельных районах умеренный или сильный дождь с грозой",
         "icon": "//cdn.weatherapi.com/weather/64x64/night/389.png",
         "code": 1276
     },
     "wind_mph": 7.8,
     "wind_kph": 12.6,
     "wind_degree": 192,
     "wind_dir": "SSW",
     "pressure_mb": 1018.0,
     "pressure_in": 30.06,
     "precip_mm": 0.0,
     "precip_in": 0.0,
     "humidity": 82,
     "cloud": 62,
     "feelslike_c": 15.3,
     "feelslike_f": 59.5,
     "windchill_c": 15.7,
     "windchill_f": 60.2,
     "heatindex_c": 15.7,
     "heatindex_f": 60.2,
     "dewpoint_c": 11.0,
     "dewpoint_f": 51.8,
     "vis_km": 10.0,
     "vis_miles": 6.0,
     "uv": 1.0,
     "gust_mph": 16.0,
     "gust_kph": 25.8
 },
 "forecast": {
     "forecastday": [тут массив из CityModelDay]
 }
 */
struct CityModel: Codable {
    let location: CityModelLocation
    let current: CityModelCurrentWeather
    let forecast: CityModelForecast
    
    init(location: CityModelLocation, current: CityModelCurrentWeather, forecast: CityModelForecast) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }
}

struct CityModelLocation: Codable {
    let name: String
    let lat: Double
    let lon: Double
    
    init(name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}

struct CityModelCurrentWeather: Codable {
    let tempC: Double
    let feelsLikeC: Double
    
    let tempF: Double
    let feelsLikeF: Double
    
    let windM: Double
    let windKm: Double
    
    let humidity: Int
    
    let cloud: Int
    
    let condition: CityModelCondition
    
    init(tempC: Double, feelsLikeC: Double, tempF: Double, feelsLikeF: Double, windM: Double, windKm: Double, humidity: Int, cloud: Int, condition: CityModelCondition) {
        self.tempC = tempC
        self.feelsLikeC = feelsLikeC
        self.tempF = tempF
        self.feelsLikeF = feelsLikeF
        self.windM = windM
        self.windKm = windKm
        self.humidity = humidity
        self.cloud = cloud
        self.condition = condition
    }
        
    private enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelsLikeC = "feelslike_c"
        case tempF = "temp_f"
        case feelsLikeF = "feelslike_f"
        case windM = "wind_mph"
        case windKm = "wind_kph"
        case humidity, cloud, condition
    }
    
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

/*
 "condition": {
     "text": "Местами дождь",
     "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
     "code": 1063
 },
 */
struct CityModelCondition: Codable {
    let text: String
    
    init(text: String) {
        self.text = text
    }
}

struct CityModelForecast: Codable {
    let foreCastByDay: [CityModelForecastByDay]
    
    private enum CodingKeys: String, CodingKey {
        case foreCastByDay = "forecastday"
    }
    
    init(foreCastByDay: [CityModelForecastByDay]) {
        self.foreCastByDay = foreCastByDay
    }
}

struct CityModelForecastByDay: Codable {
    let date: String
    let astro: CityModelAstro
    let hour: [CityModelHourForecast]
    let day: CityModelDay
    
    init(date: String, astro: CityModelAstro, hour: [CityModelHourForecast], day: CityModelDay) {
        self.date = date
        self.astro = astro
        self.hour = hour
        self.day = day
    }
}

/*
 "day": {
     "maxtemp_c": 21.2,
     "maxtemp_f": 70.1,
     "mintemp_c": 10.7,
     "mintemp_f": 51.2,
     "avgtemp_c": 15.4,
     "avgtemp_f": 59.6,
     "maxwind_mph": 10.1,
     "maxwind_kph": 16.2,
     "totalprecip_mm": 0.13,
     "totalprecip_in": 0.0,
     "totalsnow_cm": 0.0,
     "avgvis_km": 7.7,
     "avgvis_miles": 4.0,
     "avghumidity": 76,
     "daily_will_it_rain": 1,
     "daily_chance_of_rain": 84,
     "daily_will_it_snow": 0,
     "daily_chance_of_snow": 0,
     "condition": {
         "text": "Местами дождь",
         "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
         "code": 1063
     },
     "uv": 3.0
 },
 */
struct CityModelDay: Codable {
    let minTempC: Double
    let maxTempC: Double
    
    let minTempF: Double
    let maxTempF: Double
    
    let avgHumidity: Int
    
    let windSpeedM: Double
    let windSpeedK: Double
    
    let condition: CityModelCondition
    
    let rainChance: Int
    
    init(minTempC: Double, maxTempC: Double, minTempF: Double, maxTempF: Double, avgHumidity: Int, windSpeedM: Double, windSpeedK: Double, condition: CityModelCondition, rainChance: Int) {
        self.minTempC = minTempC
        self.maxTempC = maxTempC
        self.minTempF = minTempF
        self.maxTempF = maxTempF
        self.avgHumidity = avgHumidity
        self.windSpeedM = windSpeedM
        self.windSpeedK = windSpeedK
        self.condition = condition
        self.rainChance = rainChance
    }
    
    private enum CodingKeys: String, CodingKey {
        case minTempC = "mintemp_c"
        case maxTempC = "maxtemp_c"
        case minTempF = "mintemp_f"
        case maxTempF = "maxtemp_f"
        case avgHumidity = "avghumidity"
        case windSpeedM = "maxwind_mph"
        case windSpeedK = "maxwind_kph"
        case rainChance = "daily_chance_of_rain"
        case condition
    }
    
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

/*
 "astro": {
     "sunrise": "06:17 AM",
     "sunset": "06:45 PM",
     "moonrise": "06:57 PM",
     "moonset": "07:52 AM",
     "moon_phase": "Waning Gibbous",
     "moon_illumination": 99,
     "is_moon_up": 1,
     "is_sun_up": 0
 },
 */
struct CityModelAstro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    
    init(sunrise: String, sunset: String, moonrise: String, moonset: String) {
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
    }
}

/*
 "time_epoch": 1726686000,
 "time": "2024-09-19 00:00",
 "temp_c": 12.6,
 "temp_f": 54.6,
 "is_day": 0,
 "condition": {
     "text": "Дымка",
     "icon": "//cdn.weatherapi.com/weather/64x64/night/143.png",
     "code": 1030
 },
 "wind_mph": 6.5,
 "wind_kph": 10.4,
 "wind_degree": 229,
 "wind_dir": "SW",
 "pressure_mb": 1026.0,
 "pressure_in": 30.29,
 "precip_mm": 0.0,
 "precip_in": 0.0,
 "snow_cm": 0.0,
 "humidity": 94,
 "cloud": 46,
 "feelslike_c": 11.6,
 "feelslike_f": 52.9,
 "windchill_c": 11.6,
 "windchill_f": 52.9,
 "heatindex_c": 12.6,
 "heatindex_f": 54.6,
 "dewpoint_c": 11.6,
 "dewpoint_f": 52.9,
 "will_it_rain": 0,
 "chance_of_rain": 0,
 "will_it_snow": 0,
 "chance_of_snow": 0,
 "vis_km": 2.0,
 "vis_miles": 1.0,
 "gust_mph": 13.6,
 "gust_kph": 21.9,
 "uv": 0
 */
struct CityModelHourForecast: Codable {
    let tempC: Double
    let tempF: Double
    let time: String

    let condition: CityModelCondition
    
    init(tempC: Double, tempF: Double, time: String, condition: CityModelCondition) {
        self.tempC = tempC
        self.tempF = tempF
        self.time = time
        self.condition = condition
    }
    
    private enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition, time
    }

    func getTemp() -> Double {
        if SettingsStore.shared.getTempMetricMode() {
            return tempF
        } else {
            return tempC
        }
    }

    
}
