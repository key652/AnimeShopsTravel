//
//  ContentsListModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import Foundation
import Firebase

protocol ContentsListDelegate: class {
    func fetchContentsData(tableView: UITableView)
}

class ContentsList: ContentsListDelegate {
    private let ref = Database.database().reference()
    public var contentsArray = [Contents]()
    
    
    func fetchContentsData(tableView: UITableView) {
        ref.child("timeLine").queryOrdered(byChild: "createAt").observe(.value) { (snapshots) in
            self.contentsArray.removeAll()
            let snapshot = snapshots.children.allObjects as! [DataSnapshot]
            for snap in snapshot {
                guard let contentData = snap.value as? [String:Any] else { return }
                let userUid = contentData["uid"]as! String
                if UserDefaults.standard.object(forKey: "\(userUid)") != nil {
                    return
                }else{
                    self.addContentData(contentData: contentData, userUid: userUid)
                    tableView.reloadData()
                }
            }
        }
    }
    
    
    //DataBaseからContentのデーターを取り出してcontentArrayに入れる(func fetchContentData)
    private func addContentData(contentData: [String:Any], userUid: String) {
        let userName = contentData["userName"]as! String
        let profileImage = contentData["profileImage"]as! String
        let contentImage = contentData["contentImage"]as! String
        let comment = contentData["comment"]as! String
        let createDate = contentData["createAt"]
        let createAt = self.convertTimeStamp(serverTimeStamp: createDate as! CLong)
        self.contentsArray.append(Contents(userName: userName , profileImage: profileImage , createAt: createAt, contentImage: contentImage , comment: comment , uid: userUid))
    }
    
    
    
    private func convertTimeStamp(serverTimeStamp: CLong) -> String {
        let x = serverTimeStamp / 1000
        let date = Date(timeIntervalSince1970: TimeInterval(x))
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    
}