//
//  MapView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/19.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    let  mapView = MKMapView()
    let trackingButton = UIButton()
    let pinButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews(){
        addSubview(mapView)
        addSubview(trackingButton)
        
        trackingButton.setImage(UIImage(named: "ImageNorthUp"), for: .normal)
        pinButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        pinButton.setTitle("詳細", for: .normal)
        pinButton.setTitleColor(UIColor.white, for: .normal)
        pinButton.backgroundColor = CustomColor.mainColor
        
    }
    
    private func setLayout(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        trackingButton.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        trackingButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        trackingButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        trackingButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        trackingButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

