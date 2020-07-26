//
//  Contents.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//


class Contents {
    var userName: String = ""
    var profileImage: String = ""
    var createAt: String = ""
    var contentImage: String = ""
    var comment: String = ""
    var uid: String = ""
    
    
    init(userName: String, profileImage: String, createAt: String, contentImage: String, comment: String, uid: String) {
        self.userName = userName
        self.profileImage = profileImage
        self.createAt = createAt
        self.contentImage = contentImage
        self.comment = comment
        self.uid = uid
        
    }
    
    
}
