//
//  TopView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/23.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class TopView: UIView {
    var topImage = UIImageView()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        addSubview(titleLabel)
        addSubview(topImage)
        
        topImage.image = UIImage(named: "Icon")
        titleLabel.text = "アニメショップ巡り"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        
    }
    
    private func setLayout() {
        topImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        topImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 66).isActive = true
        topImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -66).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 185).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
}
