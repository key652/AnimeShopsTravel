//
//  ContributionView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/25.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class ContributionView: UIView {
    var cancelButton = UIButton()
    var profileImageView = UIImageView()
    var userNameLabel = UILabel()
    var commentTextView = UITextView()
    var contentImageView = UIImageView()
    var cameraButton = UIButton()
    var contributionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        addSubview(cancelButton)
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(commentTextView)
        addSubview(contentImageView)
        addSubview(cameraButton)
        addSubview(contributionButton)
        
        userNameLabel.adjustsFontSizeToFitWidth = true
        cameraButton.setImage(UIImage(named: "Camera"), for: .normal)
        commentTextView.font = UIFont.systemFont(ofSize: 17)
        contributionButton.setTitle("投稿", for: .normal)
        contributionButton.setTitleColor(UIColor.white, for: .normal)
        contributionButton.backgroundColor = CustomColor.mainColor
        contributionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cancelButton.setTitle("キャンセル", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    private func setLayout() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        contributionButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        profileImageView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 24).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 24).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        commentTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 28).isActive = true
        commentTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        commentTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        contentImageView.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 10).isActive = true
        contentImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        contentImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        contentImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        contributionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        contributionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35).isActive = true
        contributionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        contributionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        cameraButton.rightAnchor.constraint(equalTo: contributionButton.leftAnchor, constant: -24).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
}
