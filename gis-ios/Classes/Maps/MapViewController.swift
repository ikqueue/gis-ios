//
//  ViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: MenuController {

    @IBOutlet weak var floaty: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFloatyButton()
        setUpFilter()
        
        loadView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
        setUpBarButtonMyLocation()
        
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                checkView.firstView = String(describing: viewController)
            }
        }
    }
    
    
    func setUpFloatyButton() -> Void {
        floaty.layer.cornerRadius = 35.0
        floaty.backgroundColor = UIColor.success()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchAction))
        floaty.addGestureRecognizer(tap)
    }
    
    func setUpFilter() -> Void {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchFilter))
        filterView.addGestureRecognizer(tap)
    }
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView = map
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = map
    }
    
    @objc func touchAction() -> Void {

    }
    
    @objc func touchFilter() -> Void {
    
    }
    
    @objc func touchMyLocation() -> Void {
        
    }
}


