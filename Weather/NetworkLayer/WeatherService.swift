//
//  Servise.swift
//  Weather
//
//  Created by DimaTru on 16.05.2025.
//

import Foundation

final class WeatherService {
    private let apiKey = "d49b454e66884f75950153711251605"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "5"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


