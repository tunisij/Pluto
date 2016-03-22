//
//  PostAGameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/19/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import GoogleMaps
import FBSDKCoreKit

class PostAGameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var teamPicker: UIPickerView!
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let locationManager = CLLocationManager()
    let placesModel = PlacesModel()
    var placeMarkers = PlaceMarkers()
    var teams: Teams?
    var selectedTeam: Team?
    var user: User? {
        didSet {
            if user == nil {
                teams = []
            }
        }
    }
    
    let model = GameModel()
    let userModel = UserModel()
    let dataProvider = TeamDataProvider()
    
    override func viewDidLoad() {
        instructionLabel.hidden = false
        submitButton.hidden = true
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        startTime.minimumDate = NSDate()
    }
    
    override func viewDidAppear(animated: Bool) {
        userModel.getUser({ (user) in
            self.user = user
            
            self.dataProvider.findTeamsByUser(user, completionHandler: { (teams) in
                self.teams = teams
                self.teamPicker.reloadAllComponents()
            })
        })
    }
    
    @IBAction func submitButtonClicked(sender: UIButton) {
        if latitude != 0.0 && longitude != 0.0 {
            let persisted = model.persist(sportTextField.text!, startTime: startTime.date, team: selectedTeam, latitude: latitude, longitude: longitude)
            
            if persisted != nil {
                instructionLabel.text = persisted
                instructionLabel.textColor = UIColor.redColor()
                instructionLabel.hidden = false
            } else {
                instructionLabel.text = "Long press on the map to select a location"
                instructionLabel.textColor = UIColor.blackColor()
                instructionLabel.hidden = false
                submitButton.hidden = true
                
                resetFields()
                self.navigationController?.popViewControllerAnimated(true)
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
        
        self.instructionLabel.hidden = true
        self.submitButton.hidden = false
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if teams == nil {
           return 0
        }
        return teams!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams![row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if teams != nil && !teams!.isEmpty {
            selectedTeam = teams![row]
        }
    }
    
    func resetFields() {
        startTime.minimumDate = NSDate()
        sportTextField.text?.removeAll()
    }
    
}