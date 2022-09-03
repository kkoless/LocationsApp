//
//  LocationInfoScreenInteractor.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

protocol LocationInfoScreenInteractorProtocol {
    func getLocationInfo()
}

final class LocationInfoScreenInteractor {
    var presenter: LocationInfoScreenPresenterOutputProtocol?
    
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
}

extension LocationInfoScreenInteractor: LocationInfoScreenInteractorProtocol {
    func getLocationInfo() {
        let locationInfo = LocationInfo(coordinates: location.coordinates,
                                        name: location.name,
                                        park: location.park,
                                        state: location.state,
                                        imageName: location.imageName,
                                        isFavorite: location.isFavorite)
        
        presenter?.updateLocationInfo(with: locationInfo)
    }
}
