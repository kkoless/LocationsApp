//
//  LocationInfoViewController.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

import UIKit
import SnapKit

protocol LocationInfoViewProtocol: AnyObject {
    func showLocationInfo(with model: LocationInfo)
}

final class LocationInfoViewController: UIViewController {
    var presenter: LocationInfoScreenPresenterInputProtocol?
    
    private lazy var locationInfoView: LocationInfoView = { LocationInfoView() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}

private extension LocationInfoViewController {
    func configureUI() {
        view.backgroundColor = .white
        configureViews()
    }
    
    func configureViews() {
        view.addSubview(locationInfoView)
        
        locationInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension LocationInfoViewController: LocationInfoViewProtocol {
    func showLocationInfo(with model: LocationInfo) {
        navigationItem.title = model.name
        locationInfoView.configure(with: model)
    }
}
