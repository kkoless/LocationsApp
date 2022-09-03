//
//  LocationListTableManager.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit

protocol LocationListTableManagerProtocol: AnyObject {
    func setupTableView(with tableView: UITableView)
    func update(with items: [Location])
}

final class LocationListTableManager: LocationListTableManagerProtocol {
    weak var filterDelegate: LocationFilterDelegate?
    weak var locationDelegate: LocationTableViewCellDelegate?
    
    private weak var tableView: UITableView?
    private lazy var dataSource = LocationListScreenDataSource(tableView, filterDelegate: filterDelegate, locationDelegate: locationDelegate)
    
    private var locations: [Location] = .init()
    
    func setupTableView(with tableView: UITableView) {
        self.tableView = tableView
    }
    
    func update(with items: [Location]) {
        self.locations = items
        dataSource.apply(snapshot(), animatingDifferences: false)
    }
}

private extension LocationListTableManager {
    private func snapshot() -> LocationsListSnapshot {
        var snapshot = LocationsListSnapshot()
        
        snapshot.appendSections(LocationListSection.allCases)
        
        let filterItems = LocationListItem.filterTab
        let mainItems = locations.map { item -> LocationListItem in
            let location = LocationItem(id: item.id,
                                        name: item.name,
                                        imageName: item.imageName,
                                        isFavorite: item.isFavorite)
            return LocationListItem.locationCell(item: location)
        }
        
        
        snapshot.appendItems([filterItems], toSection: .filter)
        snapshot.appendItems(mainItems, toSection: .main)
        
        return snapshot
    }
}
