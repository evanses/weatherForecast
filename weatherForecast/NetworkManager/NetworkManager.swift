//
//  NetworkManager.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping ((Result<CityModel, NetworkError>) -> Void)) {
        let uri = "https://api.weatherapi.com/v1/forecast.json?key=6830b3712d0e4315b3d165737241709&days=10&q=\(lat),\(lon)&lang=ru"
        
        guard let url = URL(string: uri) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error {
                completion(.failure(.notInternet))
                print(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.responseError))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let res = try decoder.decode(CityModel.self, from: data)
                
                completion(.success(res))
                
            } catch (let error) {
                print(error)
                
                completion(.failure(.parsingError))
            }
            
        }.resume()
        
    }
}
