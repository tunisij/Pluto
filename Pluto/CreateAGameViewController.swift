//
//  CreateAGameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit

class CreateAGameViewController: UIViewController {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var sportTextField: UITextField!
    
    let model = CreateAGameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        startTime.minimumDate = NSDate(timeIntervalSinceNow: 900)
    }
    
    @IBAction func submitButtonClicked(sender: UIButton) {
        model.persist(sportTextField.text!, startTime: startTime.date, latitude: 42.9742, longitude: -85.9311, key: NSUUID().UUIDString)
    }
    
}