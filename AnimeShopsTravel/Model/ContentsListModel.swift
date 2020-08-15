//
//  ContentsListModel.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import Foundation
import Firebase
import MessageUI

protocol ContentsListDelegate: class {
    func fetchContentsData(tableView: UITableView, indicator: UIActivityIndicatorView)
    func selectedUserBlock(viewController: UIViewController, blockUid: String, tableView: UITableView, indicator: UIActivityIndicatorView, userName: String, comment: String, createAt: String)
}

class ContentsListModel:NSObject, ContentsListDelegate, MFMailComposeViewControllerDelegate {
    private let ref = Database.database().reference()
    public var contentsArray = [Contents]()
    
    
    func fetchContentsData(tableView: UITableView, indicator: UIActivityIndicatorView) {
        indicator.startAnimating()
        let ref = Database.database().reference().child("timeLine").queryOrdered(byChild: "createAt").observe(.value) { (snapshots) in
            self.contentsArray.removeAll()
            let snapshot = snapshots.children.allObjects as! [DataSnapshot]
            for snap in snapshot {
                guard let contentData = snap.value as? [String:Any] else { return }
                let userUid = contentData["uid"]as? String
                if UserDefaults.standard.object(forKey: "\(userUid!)") != nil {
                }else{
                    self.addContentData(contentData: contentData, userUid: userUid!)
                    tableView.reloadData()
                }
            }
            indicator.stopAnimating()
        }
    }
    
    
    func selectedUserBlock(viewController: UIViewController, blockUid: String, tableView: UITableView, indicator: UIActivityIndicatorView, userName: String, comment: String, createAt: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "\(userName)さんをブロックする", style: .default) { (alert) in
            self.contentsArray.removeAll()
            UserDefaults.standard.set(blockUid, forKey: "\(blockUid)")
            self.fetchContentsData(tableView: tableView, indicator: indicator)
            tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "投稿を報告する", style: .default) { (alert) in
            if MFMailComposeViewController.canSendMail() {
                let mailViewController: MFMailComposeViewController = self.sendMail(userName: userName, comment: comment, createAt: createAt)
                viewController.present(mailViewController, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
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
    
    
    private func sendMail(userName: String, comment: String, createAt: String) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        let toRecipents = ["rizegotiusa0130@gmail.com"]
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("投稿を報告")
        mailViewController.setToRecipients(toRecipents)
        mailViewController.setMessageBody("投稿者:\(userName) 投稿時間:\(createAt) コメント:\(comment),以上の投稿を報告します。 報告理由等ありましたら記入してください。" , isHTML:  false)
        return mailViewController
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
        case .sent:
            break
        case .saved:
            break
        case .failed:
            break
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
