//
//  KnowledgeDetailController.swift
//  gis-ios
//
//  Created by Riseplus on 1/19/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: false, backgroundColor: UIColor.primary2())
        setUpNavigationBar(barTint: UIColor.primary2(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
    }
    
    func configureNavigationBar() -> Void {
        
    }


}
