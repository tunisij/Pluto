//
//  CreateAGameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateAGameViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    let model = CreateAGameModel()
    let locationManager = CLLocationManager()
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        startTime.minimumDate = NSDate(timeIntervalSinceNow: 900)
    }
    
    @IBAction func submitButtonClicked(sender: UIButton) {
        if latitude != 0.0 && longitude != 0.0 {
            model.persist(sportTextField.text!, startTime: startTime.date, latitude: latitude, longitude: longitude, key: NSUUID().UUIDString)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        
        let placeMarker = PlaceMarker(latitude: latitude, longitude: longitude)
        mapView.clear()
        placeMarker.map = self.mapView
        self.mapView.reloadInputViews()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("failed to get location")
    }
    
    @IBAction func longPressEvent(sender: UILongPressGestureRecognizer) {
        
    }
    
    
}