//
//  ViewNearbyGamesViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/19/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class ViewNearbyGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var games: Games = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        let vc = self.parentViewController as! HomeViewController
        vc.gameToShow = games[indexPath.row]
    }

}