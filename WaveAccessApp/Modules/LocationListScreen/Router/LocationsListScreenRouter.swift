//
//  LocationsListScreenRouter.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

protocol LocationsListScreenRouterProtocol: AnyObject {
    func navigateToDetailsScreen(with location: Location)
}

final class LocationsListScreenRouter: LocationsListScreenRouterProtocol {
    var coordinator: MainCoordinator?
    
    func navigateToDetailsScreen(with location: Location) {
        coordinator?.navigateToLocationDetails(with: location)
    }
}
