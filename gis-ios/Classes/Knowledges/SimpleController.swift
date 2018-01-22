//
//  SimpleController.swift
//  gis-ios
//
//  Created by Riseplus on 1/19/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class SimpleController: TabmanViewController {
    
     private var viewControllers = [UIViewController]()
    
    var a = UIViewController()
    var b = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        // configure the bar
        self.bar.items = [Item(title: "Page 1"),
                          Item(title: "Page 2")]
        
        self.bar.style = .scrollingButtonBar
        
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            
            // customize appearance here
            appearance.state.selectedColor = UIColor.red
            appearance.text.font = .systemFont(ofSize: 16.0)
            appearance.indicator.isProgressive = true
        })
        
        
    }


}

extension SimpleController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
