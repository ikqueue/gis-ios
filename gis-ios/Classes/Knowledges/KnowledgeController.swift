//
//  KnowledgeController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var menuCollectionview: UICollectionView!
    @IBOutlet weak var tableVIEW: UITableView!
    
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectTitle: UILabel!
    @IBOutlet weak var selectClose: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenuCollection()
        setUpTableView()
        setUpBarButtonMenu()
        setUpSelectView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KnowledgeController.dismissMenu))
        blurView.addGestureRecognizer(tap)
        
        menuView.isHidden = true
        blurView.isHidden = true
        selectView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: true, backgroundColor: .clear)
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                checkView.secondView = String(describing: viewController)
            }
        }
    }
    
    func setUpMenuCollection() -> Void {
        menuCollectionview.registerCollectionViewCell(nibName: "MenuCell", identifier: "MenuCell")
    }
    
    func setUpTableView() -> Void {
        tableVIEW.registerTableViewCell(nib: "KnowledgeCell", identifier: "KnowledgeCell")
        tableVIEW.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg"))
        tableVIEW.contentMode = .scaleAspectFill
        tableVIEW.tableFooterView = UIView(frame: .zero)
    }
    
    func setUpSelectView() -> Void {
        selectView.layer.cornerRadius = 7.0
        
        selectClose.addTarget(self, action: #selector(KnowledgeController.touchsSelectClose), for: UIControlEvents.touchUpInside)
    }
    
    @objc func touchsSelectClose() -> Void {
        selectView.isHidden = true
        blurView.isHidden = true
    }
    

}

extension KnowledgeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "KnowledgeCell", for: indexPath) as! KnowledgeCell
        
        return cell
    }
    
    
}

extension KnowledgeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detail", sender: nil)
        selectView.isHidden = false
        blurView.isHidden = false
        
    }
}
