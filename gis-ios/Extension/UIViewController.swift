//
//  UIViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func setUpNavigationBar(barTint: UIColor, tint: UIColor, titleTextAt: UIColor, showTitle: Bool, title: String?) -> Void {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = barTint
        navigationController?.navigationBar.tintColor = tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleTextAt]
        
        if showTitle {
            setNavigationTitle(title: title, color: tint)
        }else {
            setNavigationTitle(title: title, color: UIColor.clear)
        }

    }
    
    func setNavigationTitle(title: String?, color: UIColor) -> Void {
        
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: title!, attributes:[
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: UIFont.setFont(font: "ThaiSansNeue-Bold", size: 30.0)])
        
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

}
