//
//  ViewController.swift
//  gis-ios
//
//  Created by Riseplus on 1/15/18.
//  Copyright © 2018 Riseplus. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var floaty: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuList: UICollectionView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var currentButton: UIButton!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenuCollection()
        setUpFloatyButton()
        setUpFilter()
        setUpBarButtonMenu()
        setUpCurrentButton()
        
        configureMapView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.dismissMenu))
        blurView.addGestureRecognizer(tap)
        
        menuView.isHidden = true
        blurView.isHidden = true
        
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
    
    func setUpCurrentButton() -> Void {
        currentButton.layer.cornerRadius = 18.0
        currentButton.layer.borderWidth = 1.0
        currentButton.layer.borderColor = UIColor.CustomLightRed().cgColor
        currentButton.backgroundColor = UIColor.CustomLightRed()
        
        currentButton.addTarget(self, action: #selector(MapViewController.touchCurrentLocation), for: UIControlEvents.touchUpInside)
    }
    
    func setUpMenuCollection() -> Void {
        menuList.registerCollectionViewCell(nibName: "MenuCell", identifier: "MenuCell")
    }
    
    func setUpFloatyButton() -> Void {
        floaty.layer.cornerRadius = 35.0
        floaty.backgroundColor = UIColor.success()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchCreateArea))
        floaty.addGestureRecognizer(tap)
    }
    
    func setUpFilter() -> Void {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.touchFilter))
        filterView.addGestureRecognizer(tap)
    }
    
    @objc func touchCurrentLocation() -> Void {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func touchCreateArea() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateAreaController") as! CreateAreaController
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    @objc func touchFilter() -> Void {
        performSegue(withIdentifier: "Filters", sender: nil)
    }
    
    @objc func touchMyLocation() -> Void {
        performSegue(withIdentifier: "myMap", sender: nil)
    }
    
    func configureMapView() -> Void {
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 15.0)
        mapView.camera = camera
        showMarker(position: camera.target)

        self.mapView?.isMyLocationEnabled = true
        
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Location"
        marker.snippet = "Current"
        marker.map = mapView
    }
    

}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
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

extension MapViewController: GMSMapViewDelegate {
    
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }
    
    
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
    }
    
    
}
