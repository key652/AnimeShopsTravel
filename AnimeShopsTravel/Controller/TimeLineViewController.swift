//
//  TimeLineViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import SDWebImage

class TimeLineViewController: UIViewController {
    @IBOutlet weak var timeLineTableView: UITableView!
    private var myUid:String?
    let contentsListModel = ContentsList()
    let userBlockModel = UserBlock()
    weak var contentsListDelegate: ContentsListDelegate?
    weak var userBlockDelegate: UserBlockDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.contentsListDelegate = contentsListModel
        self.userBlockDelegate = userBlockModel
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        if UserDefaults.standard.object(forKey: "uid") != nil {
            myUid = UserDefaults.standard.object(forKey: "uid") as! String
        }
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentsListDelegate?.fetchContentsData(tableView: timeLineTableView)
    }
    
    
    @objc private func blockButtonTaped(_ sender: BlockButton) {
        userBlockDelegate?.selectedUserBlock(viewController: self, blockUid: sender.blockUid, tableView: timeLineTableView)
    }
    
    
    @IBAction func ContributionAction(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Contribution") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    
}


extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsListModel.contentsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentsArray = contentsListModel.contentsArray
        let cell = timeLineTableView.dequeueReusableCell(withIdentifier: "timeLineCell", for: indexPath)
        
        let profileImageView = cell.viewWithTag(1)as! UIImageView
        profileImageView.sd_setImage(with: URL(string: contentsArray[contentsArray.count - indexPath.row - 1].profileImage), completed: nil)
        
        let userNameLabel = cell.viewWithTag(2)as! UILabel
        userNameLabel.text = contentsArray[contentsArray.count - indexPath.row - 1].userName
        
        let createDateLabel = cell.viewWithTag(3)as! UILabel
        createDateLabel.text = contentsArray[contentsArray.count - indexPath.row - 1].createAt
        
        let commentLabel = cell.viewWithTag(4)as! UILabel
        commentLabel.text = contentsArray[contentsArray.count - indexPath.row - 1].comment
        commentLabel.adjustsFontSizeToFitWidth = true
        
        let contentImageView = cell.viewWithTag(5)as! UIImageView
        contentImageView.sd_setImage(with: URL(string: contentsArray[contentsArray.count - indexPath.row - 1].contentImage), completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    
    
}
