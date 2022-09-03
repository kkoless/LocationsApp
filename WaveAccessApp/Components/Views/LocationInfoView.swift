//
//  LocationInfoView.swift
//  WaveAccessApp
//
//  Created by Кирилл Колесников on 03.09.2022.
//

import UIKit
import MapKit

final class LocationInfoView: UIView {
    private lazy var mapView: MKMapView = { MKMapView() }()
    private lazy var locationName: UILabel = { makeLabel(style: .title2) }()
    private lazy var locationPark: UILabel = { makeLabel(style: .caption1) }()
    private lazy var locationState: UILabel = { makeLabel(style: .caption1) }()
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationName, starImage])
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
    private lazy var commonTitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, UIStackView()])
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var subtitleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationPark, locationState])
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [commonTitleStack, subtitleStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: LocationInfo) {
        configureMap(with: model.coordinates)
        
        locationImage.image = UIImage(named: model.imageName)
        layoutIfNeeded()
        locationImage.layer.cornerRadius = locationImage.frame.width / 2
        setShadow()
        
        locationName.text = model.name
        locationPark.text = model.park
        locationState.text = model.state
        
        starImage.isHidden = !model.isFavorite ? true : false
    }
}

private extension LocationInfoView {
    func configureMap(with coordinate: Coordinate) {
        let locationCoordinate = CLLocationCoordinate2D(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        
        let region = MKCoordinateRegion(center: locationCoordinate,
                                        latitudinalMeters: 2200,
                                        longitudinalMeters: 2200)
        mapView.setRegion(region, animated: true)
    }
}

private extension LocationInfoView {
    func configureUI() {
        addSubview(mapView)
        addSubview(locationImage)
        addSubview(locationStack)
        
        locationImage.layer.zPosition = 1
        
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        locationImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(mapView.snp.bottom)
            $0.size.equalTo(230)
        }
        
        locationStack.snp.makeConstraints {
            $0.top.equalTo(locationImage.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(20)
        }
    }
}

private extension LocationInfoView {
    func makeLabel(style: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: style)
        return label
    }
    
    func setShadow() {
        let shadow = UIView(frame: .zero)
        
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOffset = CGSize(width: -2, height: 2)
        shadow.layer.shadowRadius = 10
        shadow.layer.masksToBounds = false
        shadow.clipsToBounds = false
        shadow.layer.shadowOpacity = 0.5
        
        locationImage.superview?.insertSubview(shadow, belowSubview: locationImage)
        shadow.addSubview(locationImage)
    }
}
