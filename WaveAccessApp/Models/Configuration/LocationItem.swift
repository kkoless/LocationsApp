//
//  LocationItem.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

struct LocationItem: Hashable {
    let id: Int
    let name: String
    let imageName: String
    let isFavorite: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (left: LocationItem, right: LocationItem) -> Bool {
        left.id == right.id
    }
}
