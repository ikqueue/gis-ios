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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableVIEW.registerTableViewCell(nib: "FilterSectionCell", identifier: "FilterSectionCell")
        tableVIEW.registerTableViewCell(nib: "FilterItemCell", identifier: "FilterItemCell")
    }


}

extension SimpleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableVIEW.dequeueReusableCell(withIdentifier: "FilterSectionCell") as! FilterSectionCell
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "FilterItemCell", for: indexPath) as! FilterItemCell
        
        return cell
    }
    
    
}

extension SimpleViewController: UITableViewDelegate {
    
}
