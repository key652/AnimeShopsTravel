//
//  AreaViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/24.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {
    @IBOutlet weak var areaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaTableView.delegate = self
        areaTableView.dataSource = self
    }
}

extension AreaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AreaShopsData.areaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = areaTableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        let areaLabel = cell.viewWithTag(1)as! UILabel
        areaLabel.text = AreaShopsData.areaArray[indexPath.row]
        return cell
    }
    
    
}


