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

struct State {
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
}

class MyMapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var currentButton: UIButton!
    
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    var locationManager = CLLocationManager()
    
    let rect = GMSMutablePath()
    var polygon = GMSPolygon()
    var markerDict: [String: GMSMarker] = [:]
    
    let states = [
        State(name: "Alaska", long: -152.404419, lat: 61.370716),
        State(name: "Alabama", long: -86.791130, lat: 32.806671),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "ตำแหน่งที่บันทึกไว้")
        configureCurrentLocationButton()
        configureMapView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMyMap" {
            let detination = segue.destination as! MyMapDetailController
            detination.states = states
            
        }
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
        
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        

        for state in states {
            let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            state_marker.title = state.name
            state_marker.snippet = "Hey, this is \(state.name)"
            state_marker.icon = UIImage(named: "mappin")
            state_marker.map = mapView
            markerDict[state.name] = state_marker
            arrayCoordinates.append(state_marker.position)
            rect.add(self.arrayCoordinates.last!)
        }

    }
    
    @objc func touchCurrentLocation() -> Void {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

}

extension MyMapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        performSegue(withIdentifier: "detailMyMap", sender: nil)
        return true
    }
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
            mapView.camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 1.0)
            locationManager.stopUpdatingLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

