//
//  SimpleViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/30/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {

    @IBOutlet weak var tableVIEW: UITableView!
    
    var cellDescriptors = [String]()
    var visibleRowsPerSection = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCell()
        setUpDeta()
    }

    
    func configureCell() -> Void {
        tableVIEW.registerTableViewCell(nib: "FilterSectionCell", identifier: "FilterSectionCell")
        tableVIEW.registerTableViewCell(nib: "FilterItemCell", identifier: "FilterItemCell")
        tableVIEW.tableFooterView = UIView(frame: .zero)
        tableVIEW.separatorStyle = .none
        tableVIEW?.sectionHeaderHeight = 44
        tableVIEW?.estimatedRowHeight = 44
        tableVIEW?.rowHeight = UITableViewAutomaticDimension
    }
    
    func setUpDeta() -> Void {
        
        for _ in 0...3 {
            cellDescriptors.append("Hello")
        }
        
        tableVIEW.reloadData()
    }
    
}

extension SimpleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDescriptors.count
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableVIEW.dequeueReusableCell(withIdentifier: "FilterSectionCell") as! FilterSectionCell
        
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "FilterItemCell", for: indexPath) as! FilterItemCell
        
        return cell
    }
    
    
}

extension SimpleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension SimpleViewController: HeaderViewDelegate {
    
    func toggleSection(header: FilterSectionCell, section: Int) {
        
    }
    
}
