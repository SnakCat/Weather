//
//  WeatherRow.swift
//  Weather
//
//  Created by DimaTru on 16.05.2025.
//

import SwiftUI

struct WeatherRow: View {
    
    let day: ForecastDay
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: iconURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(day.date)
                    .font(.headline)
                Text(day.day.condition.text)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 12) {
                    Label("\(Int(day.day.avgtempC))°C", systemImage: "thermometer")
                    Label("\(Int(day.day.maxwindKph)) kph", systemImage: "wind")
                    Label("\(Int(day.day.avghumidity))%", systemImage: "humidity.fill")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
    
    private var iconURL: URL? {
        let iconString = day.day.condition.icon
        if iconString.hasPrefix("//") {
            return URL(string: "https:" + iconString)
        } else {
            return URL(string: iconString)
        }
    }
}

//#Preview {
//    WeatherRow()
//}
