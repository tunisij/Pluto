//
//  ProfileViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var games: Games = []
    var gameToShow: Game?
    var user: User? {
        didSet {
            if user == nil {
                games = []
                self.tableView.reloadData()
            }
        }
    }
    
    let dataProvider = GameDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.user = nil
        
        getUser({ (user) in
            self.user = user
            self.nameLabel.text = user?.username
            
            self.dataProvider.findGames(user, completionHandler: { (games) in
                self.games = games
                self.tableView.reloadData()
            })
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = games[indexPath.row].sportKey
        cell.detailTextLabel?.text = games[indexPath.row].startTime.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        gameToShow = games[indexPath.row]
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return gameToShow != nil
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameSegue" {
            let vc = segue.destinationViewController as! GameViewController
            vc.game = gameToShow
        }
    }
    
}