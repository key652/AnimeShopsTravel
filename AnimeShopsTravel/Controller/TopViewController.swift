//
//  TopViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/23.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    private let myView = TopView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        view.backgroundColor = CustomColor.mainColor
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        }
    }

}
