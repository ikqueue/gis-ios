//
//  MyMapController.swift
//  gis-ios
//
//  Created by Riseplus on 1/22/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MyMapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var currentButton: UIButton!
    
    @IBAction func longPress(_ sender: UITapGestureRecognizer) {
        
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.map = mapView
        debugPrint(self.arrayCoordinates.last!)
    }
    
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    var longPressRecognizer = UITapGestureRecognizer()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
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
        currentButton.layer.cornerRadius = 18.0
        currentButton.layer.borderWidth = 1.0
        currentButton.layer.borderColor = UIColor.CustomLightRed().cgColor
        currentButton.backgroundColor = UIColor.CustomLightRed()
        
        currentButton.addTarget(self, action: #selector(MyMapController.touchCurrentLocation), for: UIControlEvents.touchUpInside)
    }
    
    func configureMapView() -> Void {
        mapView.delegate = self
        
        longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.longPress))
//        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self

    }
    
    
    @objc func touchCurrentLocation() -> Void {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

}

extension MyMapController: GMSMapViewDelegate {
    
}

extension MyMapController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            mapView.camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 17.0)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

extension MyMapController : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}
