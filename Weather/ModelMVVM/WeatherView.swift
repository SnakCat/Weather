//
//  ContentView.swift
//  Weather
//
//  Created by DimaTru on 16.05.2025.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select City", selection: $viewModel.selectedCity) {
                    ForEach(viewModel.cities, id: \.self) { city in
                        Text(city).tag(city)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.forecastDays) { day in
                        WeatherRow(day: day)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Weather")
        }
    }
}



#Preview {
    WeatherView()
}
