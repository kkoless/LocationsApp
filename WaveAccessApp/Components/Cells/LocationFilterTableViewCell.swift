//
//  LocationFilterTableViewCell.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit

protocol LocationFilterDelegate: AnyObject {
    func switchChanged(with state: Bool)
}

final class LocationFilterTableViewCell: UITableViewCell {
    weak var delegate: LocationFilterDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites only"
        return label
    }()
    
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, switchControl])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LocationFilterTableViewCell {
    func configureUI() {
        contentView.addSubview(horizontalStack)
        contentView.backgroundColor = .white
        
        horizontalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(5)
        }
    }
}

private extension LocationFilterTableViewCell {
    @objc func switchChanged() {
        delegate?.switchChanged(with: switchControl.isOn)
    }
}
