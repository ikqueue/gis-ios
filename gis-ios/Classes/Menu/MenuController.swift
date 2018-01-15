//
//  MenuController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuCollection: UICollectionView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var menuTitle: [String] = [
        "แผนที่",
        "ข้อมูลความรู้",
        "ดาวน์โหลด"
    ]
    
    var menuIogo: [UIImage] = [
        UIImage(named: "x-map")!,
        UIImage(named: "newspaper")!,
        UIImage(named: "save")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white)
        setUpBarButtonMenu()
        setUpBarButtonMyLocation()
        setUpMenuCollection()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MenuController.dismissMenu))
        blurView.addGestureRecognizer(tap)
    }
    
    func setUpBarButtonMenu() -> Void {
        menuView.isHidden = true
        blurView.isHidden = true
        if let image = UIImage(named: "menu"), let selector = #selector(MapViewController.touchMenu) as Selector?{
            addLeftBarButtonWithImage(image, selector: selector)
            
        }
    }
    
    func setUpBarButtonMyLocation() -> Void {
        
        if let image = UIImage(named: "bookmark"), let selector = #selector(MapViewController.touchMyLocation) as Selector?{
            addRightBarButtonWithImage(image, selector: selector, badge: 0)
            
        }
    }
    
    func setUpMenuCollection() -> Void {
        menuCollection.registerCell(nibName: "MenuCell", identifier: "MenuCell")
    }
    
    @objc func touchMenu() -> Void {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addLeftBarButtonWithImage(UIImage(named: "close")!, selector: #selector(MapViewController.dismissMenu) as Selector?)
            self.addRightBarButtonWithImage(UIImage(), selector: nil, badge: 0)
            self.setUpNavigationBar(barTint: UIColor.white, tint: UIColor.titleText(), titleTextAt: UIColor.titleText())
            self.menuView.isHidden = false
            self.blurView.isHidden = false
        }, completion: nil)
        
    }
    
    @objc func dismissMenu() -> Void {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white)
            self.setUpBarButtonMenu()
            self.setUpBarButtonMyLocation()
            
        }, completion: nil)
    }
    
    @objc func touchMyLocation() -> Void {
        
    }

}
