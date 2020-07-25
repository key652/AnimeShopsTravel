//
//  WebViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/19.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var ShopUrl:String!
    var myView = WebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        if let shopUrl = URL(string: ShopUrl) {
            self.myView.webView.load(URLRequest(url: shopUrl))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
