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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: true, backgroundColor: .clear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                checkView.secondView = String(describing: viewController)
            }
        }
    }
    
    func setUpTableView() -> Void {
        tableVIEW.registerTableViewCell(nib: "KnowledgeCell", identifier: "KnowledgeCell")
        tableVIEW.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg"))
        tableVIEW.contentMode = .scaleAspectFit
        tableVIEW.tableFooterView = UIView(frame: .zero)
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
        performSegue(withIdentifier: "detail", sender: nil)
    }
}
