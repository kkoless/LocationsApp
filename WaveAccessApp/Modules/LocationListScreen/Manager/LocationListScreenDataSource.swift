//
//  LocationListScreenDataSource.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit

enum LocationListSection: CaseIterable {
    case filter
    case main
}

enum LocationListItem: Hashable {
    case filterTab
    case locationCell(item: LocationItem)
}

typealias LocationListDataSource = UITableViewDiffableDataSource<LocationListSection, LocationListItem>
typealias LocationsListSnapshot = NSDiffableDataSourceSnapshot<LocationListSection, LocationListItem>

final class LocationListScreenDataSource: LocationListDataSource  {
    init(_ tableView: UITableView?, filterDelegate: LocationFilterDelegate?, locationDelegate: LocationTableViewCellDelegate?) {
        guard let tableView = tableView else { fatalError("UITableview is not set") }
        
        super.init(tableView: tableView) { tableView, indexPath, item in
            switch item {
                case .locationCell(item: let model):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell
                    cell?.selectionStyle = .none
                    cell?.delegate = locationDelegate
                    cell?.configure(with: model)
                    return cell
                    
                case .filterTab:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationFilterTableViewCell", for: indexPath) as? LocationFilterTableViewCell
                    cell?.selectionStyle = .none
                    cell?.delegate = filterDelegate
                    return cell
            }
        }
    }
}
