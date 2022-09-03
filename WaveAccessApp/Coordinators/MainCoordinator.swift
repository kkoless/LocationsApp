//
//  MainCoordinator.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigateToLocationListScreen()
    }
}

extension MainCoordinator {
    func navigateToLocationListScreen() {
        let locationService = LocationService()
        let router = LocationsListScreenRouter()
        let screen = LocationListScreenBuilder(router: router).build(locationService: locationService)
    
        router.coordinator = self
        
        self.navigationController.pushViewController(screen, animated: true)
    }
    
    func navigateToLocationDetails(with location: Location) {
        let screen = LocationInfoScreenBuilder.build(location: location)
        self.navigationController.pushViewController(screen, animated: true)
    }
}
