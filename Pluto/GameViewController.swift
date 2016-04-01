//
//  GameViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var game: Game! {
        didSet {
        }
    }
    var users = Users()
    
    let dataProvider = TeamDataProvider()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        sportLabel.text = game!.sportKey
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        startTime.text = formatter.stringFromDate(game!.startTime)
    }
    
    override func viewDidAppear(animated: Bool) {
        dataProvider.findUsersByTeamKey(game!.homeTeamKey) { (user) -> () in
            self.users.append(user)
            self.tableView.reloadData()
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameUsersCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = users[indexPath.row].username
        
        return cell
    }
    
    @IBAction func profileButtonClicked(sender: UIButton) {
    }
    
}