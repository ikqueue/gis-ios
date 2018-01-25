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

class PagingController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()
    private var targetIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar(barTint: UIColor.primary2(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ความเหมาะสมด้านดิน")
        self.dataSource = self
        
        self.bar.items = [
            Item(title: "ระบบชลประทาน"),
            Item(title: "การจัดการดิน"),
            Item(title: "คำแนะนำการใส่ปุ๋ย")
        ]

        self.bar.style = .scrollingButtonBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in

            appearance.indicator.color = UIColor.white
            appearance.state.selectedColor = UIColor.white
            appearance.state.color = UIColor.subtitle()
            appearance.text.font = UIFont.setFont(font: "ThaiSansNeue-Regular", size: 20.0)
        })
        
        
    }


}

extension PagingController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        var count = 0
        switch bar.style {
        case .blockTabBar, .buttonBar:
            count = 3
        default:
            count = 3
        }
        
        initializeViewControllers(count: count)
        return count
    }
    
    
    private func initializeViewControllers(count: Int) {
        let storyboard = UIStoryboard(name: "Knowledge", bundle: Bundle.main)
        var viewControllers = [UIViewController]()

        for index in 0 ..< count {
            let viewController = storyboard.instantiateViewController(withIdentifier: "KnowledgeDetailController") as! KnowledgeDetailController
            
            viewControllers.append(viewController)
        }

        self.viewControllers = viewControllers
    }
    
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
