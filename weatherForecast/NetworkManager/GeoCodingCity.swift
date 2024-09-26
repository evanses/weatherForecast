//
//  GeoCodingCity.swift
//  weatherForecast
//
//  Created by eva on 24.09.2024.
//

struct GeoCodingCity: Codable {
    let lat: String
    let lon: String
    
    private enum CodingKeys: String, CodingKey {
        case lat = "geo_lat"
        case lon = "geo_lon"
    }
}
