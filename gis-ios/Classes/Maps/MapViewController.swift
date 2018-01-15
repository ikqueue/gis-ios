//
//  ViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit

class MapViewController: MenuController {

    @IBOutlet weak var floaty: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFloatyButton()
        setUpFilter()
    }
    
    func setUpFloatyButton() -> Void {
        floaty.layer.cornerRadius = 32.5
        floaty.backgroundColor = UIColor.success()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchAction))
        floaty.addGestureRecognizer(tap)
    }
    
    func setUpFilter() -> Void {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchFilter))
        filterView.addGestureRecognizer(tap)
    }
    
    
    @objc func touchAction() -> Void {

    }
    
    @objc func touchFilter() -> Void {
    
    }
}


