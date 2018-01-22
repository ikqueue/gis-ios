//
//  KnowledgeDetailController.swift
//  gis-ios
//
//  Created by Riseplus on 1/19/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class KnowledgeDetailController: UIViewController {

    @IBOutlet weak var segment: XMSegmentedControl!
    
    var indexOfSegment: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureSegment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationCleanColor(isTranslucent: false, backgroundColor: UIColor.primary2())
        setUpNavigationBar(barTint: UIColor.primary2(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
    }
    
    func configureNavigationBar() -> Void {
        
    }
    
    func configureSegment() -> Void {
        segment.delegate = self
        segment.segmentTitle = ["ระบบชลประทาน", "การจัดการดิน", "คำแนะนำการใส่ปุ๋ย"]
        segment.selectedItemHighlightStyle = XMSelectedItemHighlightStyle.bottomEdge
        segment.backgroundColor = UIColor.primary2()
        segment.highlightColor = UIColor.white
        segment.tint = UIColor.white
        segment.highlightTint = UIColor.white
    }

}

extension KnowledgeDetailController: XMSegmentedControlDelegate {
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        
        if xmSegmentedControl == segment {
            self.indexOfSegment = selectedSegment
        }
    }
}
