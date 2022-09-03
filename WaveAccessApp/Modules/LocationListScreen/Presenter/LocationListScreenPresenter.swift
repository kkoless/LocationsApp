//
//  LocationListScreenPresenter.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

protocol LocationListScreenPresenterInputProtocol: AnyObject {
    var tableManager: LocationListTableManagerProtocol? { get set }
    func viewDidLoad()
}

protocol LocationListScreenPresenterOutputProtocol: AnyObject {
    func updateLocationList(locations: [Location])
    func navigateOnDetailsScreen(with location: Location)
}

final class LocationListScreenPresenter {
    weak var view: LocationListScreenViewProtocol?
    var tableManager: LocationListTableManagerProtocol?
    var router: LocationsListScreenRouterProtocol?
    var interactor: LocationListScreenInteractorProtocol?
}

extension LocationListScreenPresenter: LocationListScreenPresenterInputProtocol {
    func viewDidLoad() {
        interactor?.fetchLocations()
    }
}

extension LocationListScreenPresenter: LocationListScreenPresenterOutputProtocol {
    func updateLocationList(locations: [Location]) {
        tableManager?.update(with: locations)
    }
    
    func navigateOnDetailsScreen(with location: Location) {
        router?.navigateToDetailsScreen(with: location)
    }
}

extension LocationListScreenPresenter: LocationFilterDelegate {
    func switchChanged(with state: Bool) {
        interactor?.updateLocationList(isFavorites: state)
    }
}

extension LocationListScreenPresenter: LocationTableViewCellDelegate {
    func locationSelected(item: LocationItem) {
        interactor?.getLocationInfo(for: item)
    }
}
