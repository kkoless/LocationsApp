//
//  Location.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

struct Location: Codable {
    let name: String
    let category: String
    let city: String
    let state: String
    let id: Int
    let park: String
    let coordinates: Coordinate
    let imageName: String
    let isFavorite: Bool
}

struct Coordinate: Codable {
    let longitude: Double
    let latitude: Double
}
