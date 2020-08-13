//
//  ShopViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/08/01.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    @IBOutlet weak var shopTableView: UITableView!
    var shopNameArray:[String] = []
    var shopAddressArray:[String] = []
    var shopUrlArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopTableView.delegate = self
        shopTableView.dataSource = self
        shopTableView.tableFooterView = UIView(frame: .zero)
        shopTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9796229005, blue: 0.9598469873, alpha: 1)
    }
    
}


extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = shopTableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
        let shopNameLabel = cell.viewWithTag(1)as! UILabel
        let shopAddressLabel = cell.viewWithTag(2)as! UILabel
        shopNameLabel.text = shopNameArray[indexPath.row]
        shopAddressLabel.text = shopAddressArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shopTableView.deselectRow(at: indexPath, animated: true)
        let shopUrl = shopUrlArray[indexPath.row]
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "web")as! WebViewController
        nextVC.shopUrl = shopUrl
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
