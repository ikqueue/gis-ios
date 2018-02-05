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
    
    @IBOutlet weak var filterViewTab: UIView!
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    
    private var renderer: GMUGeometryRenderer!
    private var geoJsonParser: GMUGeoJSONParser!
    
    var cellDescriptors: [String] = [
        
        "แหล่งน้ำ",
        "ตำแหน่งโรงงาน",
        "เส้นชั้นน้ำฝน",
        "ความเหมาะสมด้านดิน",
        "ความเหมาะสมด้านชลประทาน",
        "ความเหมาะสมด้านน้ำใต้ดิน"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenuCollection()
        setUpFloatyButton()
        setUpFilter()
        setUpBarButtonMenu()
        setUpCurrentButton()
        
        configureSearchBar()
        configureFilterCell()
        configureMapView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.dismissMenu))
        blurView.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setUpNavigationBar(barTint: UIColor.primary1(), tint: UIColor.white, titleTextAt: UIColor.white, showTitle: true, title: "GIS ONLINE")
        setUpBarButtonMyLocation()
        
        menuView.isHidden = true
        blurView.isHidden = true
        filterViewTab.isHidden = true
        
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
    
    func configureSearchBar() -> Void {
        searchBar.backgroundColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = UIColor.white
    }
    
    func configureFilterCell() -> Void {
        
        filterTableView.registerTableViewCell(nib: "FilterSectionCell", identifier: "FilterSectionCell")
        filterTableView.registerTableViewCell(nib: "FilterItemCell", identifier: "FilterItemCell")
        filterTableView.tableFooterView = UIView(frame: .zero)
        filterTableView.separatorStyle = .none
        filterTableView?.sectionHeaderHeight = filterTableView.frame.height/6
        filterTableView?.estimatedRowHeight = 44
        filterTableView?.rowHeight = UITableViewAutomaticDimension
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
        mapView?.isMyLocationEnabled = true
        
        self.loadGeoView()
        
    }
    
    func loadGeoView() {
        
        let path = Bundle.main.path(forResource: "irrigation_out", ofType: "geojson")
        let url = URL(fileURLWithPath: path!)
        geoJsonParser = GMUGeoJSONParser(url: url)
        geoJsonParser.parse()
        
        renderer = GMUGeometryRenderer(map: mapView, geometries: geoJsonParser.features)
        renderer.render()
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
        didTabFilterAction()
    }
    
    @objc func touchMyLocation() -> Void {
        performSegue(withIdentifier: "myMap", sender: nil)
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
            mapView.camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 4.0)
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
  
}
