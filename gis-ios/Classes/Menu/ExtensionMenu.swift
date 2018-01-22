//
//  ExtensionMenu.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

struct checkView {
    static var firstView: String?
    static var secondView: String?
    static var thirdView: String?
}

extension MapViewController {
    
    func setUpBarButtonMenu() -> Void {

        if let image = UIImage(named: "menu"), let selector = #selector(MapViewController.touchMenu) as Selector?{
            addLeftBarButtonWithImage(image, selector: selector)
            
        }
    }
    
    func setUpBarButtonMyLocation() -> Void {
        
        if let image = UIImage(named: "bookmark"), let selector = #selector(MapViewController.touchMyLocation) as Selector?{
            addRightBarButtonWithImage(image, selector: selector, badge: 0)
            
        }
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
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
            var frame: CGRect = self.menuView.frame
            frame.origin.y = (self.navigationController?.navigationBar.frame.height)!
            self.menuView.frame = frame
            
            var blurFrame: CGRect = self.blurView.frame
            blurFrame.origin.y = self.menuView.frame.height //self.menuView.frame.height
            self.blurView.frame = blurFrame
            
            self.menuView.isHidden = false
            self.addLeftBarButtonWithImage(UIImage(named: "close")!, selector: #selector(MapViewController.dismissMenu) as Selector?)
            self.addRightBarButtonWithImage(UIImage(), selector: nil, badge: 0)
            self.setUpNavigationBar(barTint: UIColor.white, tint: UIColor.titleText(), titleTextAt: UIColor.titleText(), showTitle: true, title: "GIS ONLINE")
            self.blurView.isHidden = false
        }, completion: {_ in
            
            
        })
        
    }
    
    @objc func dismissMenu() -> Void {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
            var frame: CGRect = self.menuView.frame
            frame.origin.y = -frame.size.height
            self.menuView.frame = frame
            
            var blurFrame: CGRect = self.blurView.frame
            blurFrame.origin.y = -blurFrame.size.height
            self.blurView.frame = blurFrame
            
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
            
            self.blurView.isHidden = true
            
        }, completion: {_ in
            
        } )
    }
    
}


extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: menuList.frame.size.width/3-10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return collectionView.UIEdgeInsetsCell()
        
    }
}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuCell = menuList.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        menuCell.logo.image = menuIogo[indexPath.row]
        menuCell.textTItle.text = menuTitle[indexPath.row]
        return menuCell
    }
    
        
}
    
extension MapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:

            self.didPresentNavigationView(identifier: "Main", first: checkView.firstView, second: nil, third: nil)

        case 1:

            self.didPresentNavigationView(identifier: "Knowledge", first: nil, second: checkView.secondView, third: nil)

        case 2:

            self.didPresentNavigationView(identifier: "Download", first: nil, second: nil, third: checkView.thirdView)

        default:
            print(indexPath)
        }
    }
}

