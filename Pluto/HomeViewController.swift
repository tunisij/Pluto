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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var postAGameContainter: UIView!
    @IBOutlet weak var viewNearbyGamesContainer: UIView!
    
    let locationManager = CLLocationManager()
    let dataProvider = GameDataProvider()
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
    
    override func viewWillAppear(animated: Bool) {
        chooseSegmentToShow()
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
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.description)
    }
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        if placeMarkers.count > 0 {
            placeMarkers[0].map = nil
            placeMarkers.removeAll()
        }
        placeMarkers.append(PlaceMarker(latitude: coordinate.latitude, longitude: coordinate.longitude))
        placeMarkers[0].map = self.mapView
        self.mapView.reloadInputViews()
        
        var vc: PostAGameViewController
        for viewController in self.childViewControllers {
            if viewController.isKindOfClass(PostAGameViewController) {
                vc = viewController as! PostAGameViewController
                vc.instructionLabel.hidden = true
                vc.submitButton.hidden = false
                vc.latitude = coordinate.latitude
                vc.longitude = coordinate.longitude
            }
        }
        
    }
    
    @IBAction func segmentedControlClicked(sender: AnyObject) {
        chooseSegmentToShow()
    }
    
    private func chooseSegmentToShow() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.postAGameContainter.hidden = false
            self.viewNearbyGamesContainer.hidden = true
        case 1:
            self.postAGameContainter.hidden = true
            self.viewNearbyGamesContainer.hidden = false
        default:
            break;
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