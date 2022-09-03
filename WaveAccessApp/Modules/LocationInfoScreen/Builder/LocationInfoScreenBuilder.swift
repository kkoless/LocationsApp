//
//  LocationInfoScreenBuilder.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

import UIKit

struct LocationInfoScreenBuilder {
    static func build(location: Location) -> UIViewController {
        let view = LocationInfoViewController()
        let presenter = LocationInfoScreenPresenter()
        let interactor = LocationInfoScreenInteractor(location: location)
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        
        interactor.presenter = presenter

        return view
    }
}
