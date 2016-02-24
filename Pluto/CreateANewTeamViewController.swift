//
//  CreateANewTeamViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class CreateANewTeamViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    let dataProvider = CreateATeamModel()
    
    @IBAction func submitButtonClicked(sender: AnyObject) {
        dataProvider.persist(nameTextField.text!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}