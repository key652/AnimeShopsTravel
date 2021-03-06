//
//  TopViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/23.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import Firebase

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
            if Auth.auth().currentUser != nil {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") else { return }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "login") else { return }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    

}
