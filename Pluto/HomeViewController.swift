//
//  HomeViewController.swift
//  Pluto
//
//  Created by John Tunisi on 12/20/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    let dataProvider = GameDataProvider()
    let placesModel = PlacesModel()
    
    var games: Games = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(animated: Bool) {
        dataProvider.findAllGames() { (games) in
            self.mapView.clear()
            for placeMarker in self.placesModel.createPlaceMarkers(games) {
                placeMarker.map = self.mapView
                self.mapView.reloadInputViews()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("failed to get location")
    }
    
    
    
    @IBAction func createATeamButtonClicked(sender: AnyObject) {
        
    }
    
}