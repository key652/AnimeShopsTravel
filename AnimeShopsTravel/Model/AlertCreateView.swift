//
//  AlertCreateView.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class AlertCreateView: UIView {
    
    func alertCreate(title: String, message: String, actionTitle: String, viewCotroller: UIViewController) {
        let alret = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alret.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        viewCotroller.present(alret, animated: true, completion: nil)
    }
}
