//
//  LocationInfoScreenPresenter.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

protocol LocationInfoScreenPresenterInputProtocol: AnyObject {
    func viewDidLoad()
}

protocol LocationInfoScreenPresenterOutputProtocol: AnyObject {
    func updateLocationInfo(with: LocationInfo)
}

final class LocationInfoScreenPresenter {
    var view: LocationInfoViewProtocol?
    var interactor: LocationInfoScreenInteractorProtocol?
}

extension LocationInfoScreenPresenter: LocationInfoScreenPresenterInputProtocol {
    func viewDidLoad() {
        interactor?.getLocationInfo()
    }
}

extension LocationInfoScreenPresenter: LocationInfoScreenPresenterOutputProtocol {
    func updateLocationInfo(with model: LocationInfo) {
        view?.showLocationInfo(with: model)
    }
}
