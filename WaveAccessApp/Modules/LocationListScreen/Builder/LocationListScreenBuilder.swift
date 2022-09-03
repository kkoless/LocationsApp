//
//  LocationListScreenBuilder.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

import UIKit

struct LocationListScreenBuilder {
    private let router: LocationsListScreenRouterProtocol

    init(router: LocationsListScreenRouterProtocol) {
        self.router = router
    }

    func build(locationService: LocationServiceProtocol) -> UIViewController {
        let view = LocationListScreenViewController()
        let presenter = LocationListScreenPresenter()
        let interactor = LocationListScreenInteractor(locationService: locationService)
        let tableManager = LocationListTableManager()

        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.tableManager = tableManager
        presenter.router = router
        
        tableManager.filterDelegate = presenter
        tableManager.locationDelegate = presenter
        
        interactor.presenter = presenter

        return view
    }
}
