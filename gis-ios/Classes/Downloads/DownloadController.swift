//
//  DownloadController.swift
//  gis-ios
//
//  Created by Riseplus on 1/16/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class DownloadController: UIViewController {

    @IBOutlet weak var tableVIEW: UITableView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuCollection: UICollectionView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.dismissMenu))
        menuBlur.addGestureRecognizer(tap)
        
        menuView.isHidden = true
        menuBlur.isHidden = true
        
        setUpBarButtonMenu()
        setUpMenuCollection()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationBar(barTint: UIColor.primary3(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ดาวน์โหลด")
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                checkView.thirdView = String(describing: viewController)
            }
        }
    }
    
    func setUpTableView() -> Void {
        tableVIEW.registerTableViewCell(nib: "DownloadCell", identifier: "DownloadCell")
        tableVIEW.tableFooterView = UIView(frame: .zero)
        tableVIEW.setHeightCellAutomatic(estimatedRowHeight: 90)
    }
    
    func setUpMenuCollection() -> Void {
        menuCollection.registerCollectionViewCell(nibName: "MenuCell", identifier: "MenuCell")
    }
    
}

extension DownloadController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath) as! DownloadCell
        
        return cell
    }
    
}

extension DownloadController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
}
