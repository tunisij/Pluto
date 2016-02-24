//
//  SquadsTableViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class TeamsTableViewController: UITableViewController {
    var teams: Teams = []
    var teamToShow: Team?
    var user: User? {
        didSet {
            if user == nil {
                teams = []
                self.tableView.reloadData()
            }
        }
    }
    
    let dataProvider = TeamDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.user = nil
        
        getUser({ (user) in
            self.user = user
            
            self.dataProvider.findAllTeams({ (teams) in
                self.teams = teams
                self.tableView.reloadData()
            })
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return tableView.dequeueReusableCellWithIdentifier("createANewTeamCell", forIndexPath: indexPath)
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("teamCell", forIndexPath: indexPath)
            
            cell.textLabel!.text = teams[indexPath.row - 1].name
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("createATeamSegue", sender: self)
        default:
            teamToShow = teams[indexPath.row - 1]
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return teamToShow != nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teamSegue" {
            let vc = segue.destinationViewController as! TeamViewController
            vc.team = teamToShow
        }
    }
}