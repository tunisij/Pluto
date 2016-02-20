//
//  GameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class GameViewController: UIViewController {
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    var game: Game?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        sportLabel.text = game?.sportKey
        startTime.text = game?.startTime.description
    }
    
    @IBAction func profileButtonClicked(sender: UIButton) {
    }
    
}