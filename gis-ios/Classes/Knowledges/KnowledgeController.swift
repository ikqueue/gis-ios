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
    @IBOutlet weak var selectBlur: UIVisualEffectView!
    @IBOutlet weak var selectTable: UITableView!
    
    
    var items: [String] = [
        "ความเหมาะสมด้านดินมาก (Soil-1)",
        "ความเหมาะสมด้านดินปานกลาง (Soil-2)",
        "ความเหมาะสมด้านดินน้อย (Soil-3)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenuCollection()
        setUpTableView()
        setUpBarButtonMenu()
        setUpSelectView()
        setUpTouchView()

        selectTitle.text = "เหมาะสมมากที่สุด (S1)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: true, backgroundColor: .clear)
        menuView.isHidden = true
        blurView.isHidden = true
        selectView.isHidden = true
        selectBlur.isHidden = true
        
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
        
        selectTable.registerTableViewCell(nib: "KnowledgeSelectCell", identifier: "KnowledgeSelectCell")
        selectTable.tableFooterView = UIView(frame: .zero)
    }
    
    func setUpSelectView() -> Void {
        selectView.layer.cornerRadius = 7.0
        
        selectClose.addTarget(self, action: #selector(KnowledgeController.touchsSelectClose), for: UIControlEvents.touchUpInside)
    }
    
    func setUpTouchView() -> Void {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KnowledgeController.dismissMenu))
        blurView.addGestureRecognizer(tap)
        
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KnowledgeController.touchsSelectClose))
        selectBlur.addGestureRecognizer(tap2)
        
    }
    
    @objc func touchsSelectClose() -> Void {
        selectView.isHidden = true
        selectBlur.isHidden = true
    }
    

}

extension KnowledgeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.tableVIEW {
            count = 1
        }
        
        if tableView == self.selectTable {
            count = items.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableVIEW {
            let cell = tableVIEW.dequeueReusableCell(withIdentifier: "KnowledgeCell", for: indexPath) as! KnowledgeCell
            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "KnowledgeSelectCell", for: indexPath) as! KnowledgeSelectCell
            cell.message.text = items[indexPath.row]
            return cell
        }
        
//        if tableView == self.selectTable {
//
//        }
        

    }
    
    
}

extension KnowledgeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectView.isHidden = false
        selectBlur.isHidden = false
        
        if tableView == self.tableVIEW {
            
        }
        
        if tableView == self.selectTable {
            performSegue(withIdentifier: "detail", sender: nil)
        }
        
    }
}
