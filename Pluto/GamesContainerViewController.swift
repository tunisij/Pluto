//
//  GamesContainerViewController.swift
//  Pluto
//
//  Created by John Tunisi on 3/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class GamesContainerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var upcomingGamesTableView: UITableView!
    @IBOutlet weak var previousGamesTableView: UITableView!
    
    var upcomingGames: Games = []
    var previousGames: Games = []
    
    var user: User? {
        didSet {
            if user == nil {
                upcomingGames = []
                previousGames = []
                upcomingGamesTableView.reloadData()
                previousGamesTableView.reloadData()
            }
        }
    }
    
    let gameDataProvider = GameDataProvider()
    
    let model = TeamModel()
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.upcomingGamesTableView.delegate = self
        self.upcomingGamesTableView.dataSource = self
        self.previousGamesTableView.delegate = self
        self.previousGamesTableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    private func getData() {
        userModel.getUser({ (user) in
            self.user = user
            
            self.upcomingGames = []
            self.previousGames = []
            
            self.gameDataProvider.findUpcomingGames(user!, completionHandler: { (upcomingGames) in
                self.upcomingGames.appendContentsOf(upcomingGames)
                self.upcomingGamesTableView.reloadData()
            })
            
            self.gameDataProvider.findPreviousGames(user!, completionHandler: { (previousGames) in
                self.previousGames.appendContentsOf(previousGames)
                self.previousGamesTableView.reloadData()
            })
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == upcomingGamesTableView ? upcomingGames.count: previousGames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == upcomingGamesTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("upcomingGameCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = upcomingGames[indexPath.row].sportKey
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("previousGameCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = previousGames[indexPath.row].sportKey
            
            return cell
            
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if tableView == self.upcomingGamesTableView {
//            self.performSegueWithIdentifier("showUpcomingGameSegue", sender: self)
//        } else if tableView == self.previousGamesTableView {
//            self.performSegueWithIdentifier("showPreviousGameSegue", sender: self)
//        }
    }
}