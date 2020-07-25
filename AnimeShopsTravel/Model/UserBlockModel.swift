//
//  UserBlockModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/25.
//  Copyright © 2020 yuma yada. All rights reserved.
//
import UIKit

protocol UserBlockDelegate: class {
    func selectedUserBlock(viewController: UIViewController, blockUid: String)
}

class UserBlock: UserBlockDelegate {
    private let contentList = ContentsList()
    
    func selectedUserBlock(viewController: UIViewController, blockUid: String) {
        let alert = UIAlertController(title: "ブロック", message: "このユーザーをブロックしますか？", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "ブロックする", style: .default) { (alert) in
            UserDefaults.standard.set(blockUid, forKey: "\(blockUid)")
            self.contentList.fetchContentsData()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
