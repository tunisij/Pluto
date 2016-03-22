//
//  HomeViewController.swift
//  Pluto
//
//  Created by John Tunisi on 12/20/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewNearbyGamesContainer: UIView!
    @IBOutlet weak var postAGameButton: UIButton!
    
    let locationManager = CLLocationManager()
    let dataProvider = GameDataProvider()
    let userModel = UserModel()
    let placesModel = PlacesModel()
    var placeMarkers = PlaceMarkers()
    
    var games: Games = [] {
        didSet {
            var vc: ViewNearbyGamesViewController
            for viewController in self.childViewControllers {
                if viewController.isKindOfClass(ViewNearbyGamesViewController) {
                    vc = viewController as! ViewNearbyGamesViewController
                    vc.games = games
                }
            }
        }
    }
    
    var gameToShow: Game? {
        didSet {
            self.performSegueWithIdentifier("showGameSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let isLoggedIn = userModel.isUserLoggedIn()
        postAGameButton.hidden = !isLoggedIn
        
        populateMapWithGames()
    }
    
    private func populateMapWithGames() {
        dataProvider.findGamesNearby(locationManager.location?.coordinate.latitude, longitude: locationManager.location?.coordinate.longitude) { (games) in
            self.games = games
            self.mapView.clear()
            
            if self.placeMarkers.count > 0 {
                self.placeMarkers[0].map = self.mapView
            }
            
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
        } else if status == .Denied {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            
            populateMapWithGames()
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "showGameSegue" {
            return gameToShow != nil
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGameSegue" {
            let vc = segue.destinationViewController as! GameViewController
            vc.game = gameToShow
        }
    }
    
}