//
//  UIViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func setUpNavigationBar(barTint: UIColor, tint: UIColor, titleTextAt: UIColor) -> Void {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = barTint
        navigationController?.navigationBar.tintColor = tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleTextAt]
        
        
        
        let navLabel = UILabel()
        
        let navTitle = NSMutableAttributedString(string: "GIS ONLINE", attributes:[
            NSAttributedStringKey.foregroundColor: tint,
            NSAttributedStringKey.font: UIFont(name: "ThaiSansNeue-Bold", size: 30.0) ?? 0])
        
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        
        
        
    }
    
    public func addLeftBarButtonWithImage(_ buttonImage: UIImage, selector: Selector?=nil) {
        
        let button = UIButton.init(type: .custom)
        button.setImage(buttonImage, for: UIControlState.normal)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        button.imageView?.contentMode = .scaleAspectFit
        let barButton = UIBarButtonItem.init(customView: button)
        
        if let selector: Selector = selector {
            button.addTarget(self, action:selector, for: UIControlEvents.touchUpInside)
        }
        
        navigationItem.leftBarButtonItem = barButton
    }
    
    public func addRightBarButtonWithImage(_ buttonImage: UIImage, selector: Selector?=nil, badge: Int) {
        
        let button = UIButton.init(type: .custom)
        button.setImage(buttonImage, for: UIControlState.normal)
//        button.addTarget(self, action:#selector(myLocation), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem.init(customView: button)
        
        if let selector: Selector = selector {
            button.addTarget(self, action:selector, for: UIControlEvents.touchUpInside)
        }
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func myLocation() {
        
    }
}
