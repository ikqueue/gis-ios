//
//  MyMapDetailController.swift
//  gis-ios
//
//  Created by Riseplus on 1/26/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MyMapDetailController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var currentLocation: UIButton!
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var dateText: UILabel!
    
    @IBOutlet weak var dismissData: UIButton!
    @IBOutlet weak var removeData: UIButton!
    
    var locationManager = CLLocationManager()
    
    var states = [State]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        configureCurrentLocation()
        configureCardView()
        
        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ตำแหน่งที่บันทึกไว้")
        
        dataView.isHidden = false
    }
    
    func configureMapView() -> Void {
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        
        locationManager.delegate = self
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        
    }
    
    func configureCurrentLocation() -> Void {
        
        currentLocation.layer.cornerRadius = 18.0
        currentLocation.layer.borderWidth = 1.0
        currentLocation.layer.borderColor = UIColor.CustomLightRed().cgColor
        currentLocation.backgroundColor = UIColor.CustomLightRed()
        
        currentLocation.addTarget(self, action: #selector(MyMapDetailController.touchCurrentLocation), for: UIControlEvents.touchUpInside)
    }
    
    func configureCardView() -> Void {
        
        dataView.layer.cornerRadius = 7.0
        dataView.layer.borderWidth = 1.0
        dataView.layer.borderColor = UIColor.clear.cgColor
        dataView.layer.masksToBounds = true
        
        dismissData.addTarget(self, action: #selector(MyMapDetailController.dismissView), for: UIControlEvents.touchUpInside)
        removeData.addTarget(self, action: #selector(MyMapDetailController.removeMyLocation), for: UIControlEvents.touchUpInside)
    }
    
    @objc func dismissView() -> Void {
        dataView.isHidden = true
    }
    
    @objc func removeMyLocation() -> Void {
        dataView.isHidden = true
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchCurrentLocation() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension MyMapDetailController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        dataView.isHidden = false
        return true
    }
}

extension MyMapDetailController: CLLocationManagerDelegate {
    
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
