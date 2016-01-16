//
//  HomeViewController.swift
//  Pluto
//
//  Created by John Tunisi on 12/20/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}