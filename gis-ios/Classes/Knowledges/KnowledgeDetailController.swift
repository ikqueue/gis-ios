//
//  KnowledgeDetailController.swift
//  gis-ios
//
//  Created by Riseplus on 1/19/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeDetailController: UIViewController {

    @IBOutlet weak var headText: UILabel!
    @IBOutlet weak var firstSectionText: UILabel!
    @IBOutlet weak var secondSectionText: UILabel!
    @IBOutlet weak var footerText: UILabel!
    
    @IBOutlet weak var tableView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headText.text = "พื้นที่ที่อยู่ในเขตชลประทาน"
        firstSectionText.text = "การออกแบบชลประทาน"
        secondSectionText.text = "รูปภาพ"
        footerText.text = "พื้นที่ที่อยู่ในเขตชลประทาน"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: false, backgroundColor: UIColor.primary2())
        setUpNavigationBar(barTint: UIColor.primary2(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
    }


}
