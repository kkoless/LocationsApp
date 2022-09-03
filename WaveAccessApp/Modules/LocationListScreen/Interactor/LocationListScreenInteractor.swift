//
//  LocationListScreenInteractor.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

protocol LocationListScreenInteractorProtocol: AnyObject {
    func fetchLocations()
    func updateLocationList(isFavorites: Bool)
    func getLocationInfo(for item: LocationItem)
}

final class LocationListScreenInteractor  {
    var presenter: LocationListScreenPresenterOutputProtocol?
    
    private let locationService: LocationServiceProtocol
    private var locations: [Location]
    
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
        self.locations = []
    }
}

extension LocationListScreenInteractor: LocationListScreenInteractorProtocol {
    func fetchLocations() {
        locations = locationService.getLocation()
        presenter?.updateLocationList(locations: locations)
    }
    
    func updateLocationList(isFavorites: Bool) {
        let items = isFavorites ? locations.filter { $0.isFavorite } : locations
        presenter?.updateLocationList(locations: items)
    }
    
    func getLocationInfo(for item: LocationItem) {
        if let info = locations.first(where: { $0.id == item.id }) {
            presenter?.navigateOnDetailsScreen(with: info)
        }
    }
}
