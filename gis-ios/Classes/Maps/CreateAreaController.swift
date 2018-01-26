//
//  CreateAreaController.swift
//  gis-ios
//
//  Created by Riseplus on 1/25/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class CreateAreaController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var menuList: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    @IBOutlet weak var processView: UIView!
    @IBOutlet weak var processText1: UILabel!
    @IBOutlet weak var processText2: UILabel!
    @IBOutlet weak var dismissProcess: UIButton!
    
    @IBOutlet weak var floaty: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    var longPressRecognizer = UITapGestureRecognizer()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var polygon = GMSPolygon()
    let rect = GMSMutablePath()
    
    @IBAction func longPress(_ sender: UITapGestureRecognizer) {
        
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        newMarker.icon = UIImage(named: "mappin")
        
        self.arrayCoordinates.append(newMarker.position)
        rect.add(self.arrayCoordinates.last!)
        
        newMarker.map = mapView
        debugPrint(self.arrayCoordinates.last!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAreaController.dismissMenu))
        menuBlur.addGestureRecognizer(tap)
        
        dismissButton.addTarget(self, action: #selector(CreateAreaController.dismissAction), for: UIControlEvents.touchUpInside)
        menuList.registerCollectionViewCell(nibName: "MenuCell", identifier: "MenuCell")
        setUpBarButtonMenu()
        setUpFloatyButton()
        setUpProcessView()
        setUpProcessView()
        
        configureMapView()
        
        menuView.isHidden = true
        menuBlur.isHidden = true
        processView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
        setUpBarButtonMyLocation()
    }
    
    func configureMapView() -> Void {
        mapView.delegate = self
        
        longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.longPress))
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
    
    func setUpFloatyButton() -> Void {
        floaty.layer.cornerRadius = 35.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAreaController.touchProcess))
        floaty.addGestureRecognizer(tap)
    }
    
    func setUpProcessView() -> Void {
        processView.layer.cornerRadius = 5.0
        
        dismissProcess.addTarget(self, action: #selector(CreateAreaController.dismissProcessView), for: UIControlEvents.touchUpInside)
    }
    

    @objc func dismissAction() -> Void {
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
    
    @objc func touchMyLocation() -> Void {
        performSegue(withIdentifier: "myMap", sender: nil)
    }
    
    @objc func touchProcess() -> Void {
        processView.isHidden = false
        
        polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor.CustomLightRed()
        polygon.strokeColor = UIColor.warning()
        polygon.strokeWidth = 2
        polygon.map = mapView
    }
    
    @objc func dismissProcessView() -> Void {
        processView.isHidden = true
    }

}

extension CreateAreaController: GMSMapViewDelegate {
    
}

extension CreateAreaController: CLLocationManagerDelegate {
    
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

extension CreateAreaController : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}

