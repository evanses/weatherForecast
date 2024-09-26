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
    
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping ((Result<ApiCityModel, NetworkError>) -> Void)) {
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
                
                let res = try decoder.decode(ApiCityModel.self, from: data)
                
                completion(.success(res))
                
            } catch (let error) {
                print(error)
                
                completion(.failure(.parsingError))
            }
            
        }.resume()
    }
    
    func geoCoding(cityName: String, completion: @escaping ((Result<GeoCodingCity, NetworkError>) -> Void)) {
        let parameters = "[\"\(cityName)\"]"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://cleaner.dadata.ru/api/v1/clean/address")!,timeoutInterval: Double.infinity)
        request.addValue("70675be5516f1a1c210b25472af770f941a0c7cd", forHTTPHeaderField: "X-Secret")
        request.addValue("Token 32545dd9ade3cf0a34ea73ac72037ace740d4a7c", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                
                let res = try decoder.decode([GeoCodingCity].self, from: data)
                
                print(res)
                
                completion(.success(res.first!))
                
            } catch (let error) {
                print(error)
                
                completion(.failure(.parsingError))
            }
        }

        task.resume()

    }
}
