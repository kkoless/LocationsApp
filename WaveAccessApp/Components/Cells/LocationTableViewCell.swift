//
//  LocationTableViewCell.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 02.09.2022.
//

import UIKit

protocol LocationTableViewCellDelegate: AnyObject {
    func locationSelected(item: LocationItem)
}

final class LocationTableViewCell: UITableViewCell {
    weak var delegate: LocationTableViewCellDelegate?
    private var locationItem: LocationItem?
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var locationTitle: UILabel = { UILabel() }()
    
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationImage,
                                                   locationTitle,
                                                   starImage])
        stack.setCustomSpacing(10, after: locationImage)
        stack.setCustomSpacing(5, after: locationTitle)
        stack.alignment = .center
        return stack
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, arrowButton])
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: LocationItem) {
        locationImage.image = UIImage(named: model.imageName)
        
        layoutIfNeeded()
        locationImage.layer.cornerRadius = locationImage.frame.size.width / 2
        
        locationTitle.text = model.name
        
        starImage.isHidden = !model.isFavorite ? true : false
        
        locationItem = model
    }
}

private extension LocationTableViewCell {
    func configureUI() {
        configureViews()
        configureStack()
    }
    
    func configureStack() {
        contentView.addSubview(horizontalStack)
        
        horizontalStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(5)
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        
        locationImage.snp.makeConstraints {
            $0.size.equalTo(45)
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        arrowButton.snp.makeConstraints {
            $0.size.equalTo(15)
        }
    }
}

private extension LocationTableViewCell {
    func configureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        if let item = locationItem {
            delegate?.locationSelected(item: item)
        }
    }
}
