//
//  MyMapController.swift
//  gis-ios
//
//  Created by Riseplus on 1/22/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps

class MyMapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var currentButton: UIButton!
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        debugPrint("You tapped at YES")
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.map = mapView
    }
    
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    var longPressRecognizer = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureCurrentLocationButton()
        configureMapView()
        
    }
    
    func configureNavigationBar() -> Void {
        navigationItem.title = "ตำแหน่งที่บันทึกไว้"
    }
    
    func configureCurrentLocationButton() -> Void {
        currentButton.layer.cornerRadius = 15.0
        currentButton.backgroundColor = UIColor.CustomLightRed()
        
        currentButton.addTarget(self, action: #selector(MyMapController.touchCurrentLocation), for: UIControlEvents.touchUpInside)
    }
    
    func configureMapView() -> Void {
        mapView.delegate = self
        
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        

    }
    
    
    @objc func touchCurrentLocation() -> Void {
        
    }

}

extension MyMapController: GMSMapViewDelegate {
    
}

extension MyMapController : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}
