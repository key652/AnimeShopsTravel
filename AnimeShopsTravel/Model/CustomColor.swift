//
//  CustomColor.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/19.
//  Copyright © 2020 yuma yada. All rights reserved.
//
import UIKit

struct CustomColor {
    static let mainColor = UIColor(red: 0.27, green: 0.74, blue: 0.70, alpha: 1)
    static let logoutButtonColor = UIColor(red: 0.92, green: 0.40, blue: 0.44, alpha: 1)
}

class BlockButton: UIButton {
    var blockUid: String = ""
    var userName: String = ""
    var comment: String = ""
    var createAt: String = ""
}

