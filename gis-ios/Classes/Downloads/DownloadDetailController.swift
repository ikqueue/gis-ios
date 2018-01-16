//
//  DownloadDetailController.swift
//  gis-ios
//
//  Created by Riseplus on 1/16/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import WebKit

class DownloadDetailController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url : URL! = URL(string: "https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html#//apple_ref/doc/uid/TP40014097-CH3-ID0")
        webView.loadRequest(URLRequest(url: url))
        addRightBarButton()
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() -> Void {
        navigationItem.title = "ต้นทุนการผลิตอ้อย.pdf"
    }
    
    func addRightBarButton() -> Void {
        
        if let image = UIImage(named: "download-white"), let selector = #selector(DownloadDetailController.touchDownload) as Selector?{
            addRightBarButtonWithImage(image, selector: selector, badge: 0)
            
        }
    }
    
    @objc func touchDownload() -> Void {
        
    }

}
