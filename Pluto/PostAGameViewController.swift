//
//  PostAGameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/19/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class PostAGameViewController: UIViewController {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var teamPicker: UIPickerView!
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    let model = CreateAGameModel()
    
    override func viewDidLoad() {
        instructionLabel.hidden = false
        submitButton.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        startTime.minimumDate = NSDate(timeIntervalSinceNow: 900)
    }
    
    @IBAction func submitButtonClicked(sender: UIButton) {
        if latitude != 0.0 && longitude != 0.0 {
            let persisted = model.persist(sportTextField.text!, startTime: startTime.date, latitude: latitude, longitude: longitude)
            
            if persisted != nil {
                instructionLabel.text = persisted
                instructionLabel.textColor = UIColor.redColor()
            } else {
                instructionLabel.text = "Long press on the map to select a location"
                instructionLabel.textColor = UIColor.blackColor()
                submitButton.hidden = true
                
                resetFields()
            }
            
            instructionLabel.hidden = false
            
        }
    }
    
    func resetFields() {
        startTime.minimumDate = NSDate(timeIntervalSinceNow: 900)
        sportTextField.text?.removeAll()
    }
    
}