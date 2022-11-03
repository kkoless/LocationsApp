//
//  LocationListScreenViewController.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit
import SnapKit

protocol LocationListScreenViewProtocol: AnyObject {
    var presenter: LocationListScreenPresenterInputProtocol? { get set }
}

final class LocationListScreenViewController: UIViewController {
    var presenter: LocationListScreenPresenterInputProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(LocationFilterTableViewCell.self, forCellReuseIdentifier: "LocationFilterTableViewCell")
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.tableManager?.setupTableView(with: tableView)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

private extension LocationListScreenViewController {
    func configureUI() {
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Landmarks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LocationListScreenViewController: LocationListScreenViewProtocol {}
