//
//  ViewModel.swift
//  Weather
//
//  Created by DimaTru on 16.05.2025.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var forecastDays: [ForecastDay] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private let weatherService = WeatherService()
    let cities = ["Moscow", "London", "New York", "Tokyo", "Paris"]
    @Published var selectedCity: String = "Moscow" {
        didSet {
            fetchWeather()
        }
    }
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(for: selectedCity) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let response):
                    self?.forecastDays = response.forecast.forecastday
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.forecastDays = []
                }
            }
        }
    }
}
