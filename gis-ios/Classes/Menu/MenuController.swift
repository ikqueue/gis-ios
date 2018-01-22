//
//  MenuController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps


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
        
        let height: CGFloat = self.menuView.frame.size.height
        let width: CGFloat = self.menuView.frame.size.width
        self.menuView.frame = CGRect(x: 0, y: -height, width: width, height: height)
        
        setUpBarButtonMenu()
        setUpMenuCollection()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MenuController.dismissMenu))
        blurView.addGestureRecognizer(tap)
    }

    func setUpBarButtonMenu() -> Void {
        menuView.isHidden = true
        blurView.isHidden = true
        if let image = UIImage(named: "menu"), let selector = #selector(MenuController.touchMenu) as Selector?{
            addLeftBarButtonWithImage(image, selector: selector)
            
        }
    }
    
    func setUpBarButtonMyLocation() -> Void {
        
        if let image = UIImage(named: "bookmark"), let selector = #selector(MapViewController.touchMyLocation) as Selector?{
            addRightBarButtonWithImage(image, selector: selector, badge: 0)
            
        }
    }
    
    func setUpMenuCollection() -> Void {
        menuCollection.registerCollectionViewCell(nibName: "MenuCell", identifier: "MenuCell")
    }
    
    func didPresentNavigationView(identifier: String,first: String?, second: String?, third: String?) {
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                
                if first != nil {
                    
                    if first == String(describing: viewController) {
                        dismissMenu()
                    }else {
                        if let vc = UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as? UINavigationController {
                            present(vc, animated: true, completion: nil)
                        }
                    }
                    
                }else if second != nil {
                    
                    if second == String(describing: viewController) {
                        dismissMenu()
                    }else {
                        if let vc = UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as? UINavigationController {
                            present(vc, animated: true, completion: nil)
                        }
                    }

                }else {
                    if third == String(describing: viewController) {
                        dismissMenu()
                    }else {
                        if let vc = UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as? UINavigationController {
                            present(vc, animated: true, completion: nil)
                        }
                    }
                }

            }
        }
    }
    
    @objc func touchMenu() -> Void {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
            var frame: CGRect = self.menuView.frame
            frame.origin.y = 0
            self.menuView.frame = frame
            
            self.menuView.isHidden = false
            self.addLeftBarButtonWithImage(UIImage(named: "close")!, selector: #selector(MenuController.dismissMenu) as Selector?)
            self.addRightBarButtonWithImage(UIImage(), selector: nil, badge: 0)
            self.setUpNavigationBar(barTint: UIColor.white, tint: UIColor.titleText(), titleTextAt: UIColor.titleText(), showTitle: true, title: "GIS ONLINE")
            
        }, completion: {_ in

            self.blurView.isHidden = false
        })
        
    }
    
    @objc func dismissMenu() -> Void {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
            var frame: CGRect = self.menuView.frame
            frame.origin.y = -frame.size.height
            self.menuView.frame = frame
            
            if let window = UIApplication.shared.delegate?.window {
                if var viewController = window?.rootViewController {
                    if(viewController is UINavigationController){
                        viewController = (viewController as! UINavigationController).visibleViewController!
                    }
                    if checkView.secondView == String(describing: viewController) {
                        self.setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: false, title: "")
                        self.setUpBarButtonMenu()
                    }else if checkView.thirdView == String(describing: viewController){
                        self.setUpNavigationBar(barTint: UIColor.primary3(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ดาวน์โหลด")
                        self.setUpBarButtonMenu()
                    }else {
                        self.setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
                        self.setUpBarButtonMenu()
                        self.setUpBarButtonMyLocation()
                    }
                }
            }

        }, completion: nil )
    }

}
