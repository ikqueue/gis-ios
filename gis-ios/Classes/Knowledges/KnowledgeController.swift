//
//  KnowledgeController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeController: UIViewController {

    @IBOutlet weak var tableVIEW: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
    }
    
    func setUpTableView() -> Void {
        tableVIEW.registerTableViewCell(nib: "KnowledgeCell", identifier: "KnowledgeCell")
        tableVIEW.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg"))
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
    
}
