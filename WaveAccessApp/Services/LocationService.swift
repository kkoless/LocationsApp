//
//  LoxationService.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import Foundation

protocol LocationServiceProtocol {
    func getLocation() -> [Location]
}

struct LocationService: LocationServiceProtocol {
    func getLocation() -> [Location] {
        var locations = [Location]()
        if let url = Bundle.main.url(forResource: "landmarkData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                locations = try decoder.decode([Location].self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
        return locations
    }
}
