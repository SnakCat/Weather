//
//  Errors.swift
//  Weather
//
//  Created by DimaTru on 16.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse(statusCode: Int)
    case noData
}
