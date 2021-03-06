//
//  ViewNearbyGamesViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/19/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class ViewNearbyGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isEmpty = true
    
    var games: Games = [] {
        didSet {
            isEmpty = games.count <= 0
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
        return isEmpty ? 1 : games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath)
        
        if !isEmpty {
            cell.textLabel!.text = games[indexPath.row].sportKey
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
                        
            cell.detailTextLabel?.text = formatter.stringFromDate(games[indexPath.row].startTime)
        } else {
            switch indexPath.row {
            case 0: cell.textLabel?.text = "There are no games nearby"
                cell.detailTextLabel?.text = nil
            default: cell.detailTextLabel?.text = nil
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !isEmpty {
            let vc = self.parentViewController as! HomeViewController
            vc.gameToShow = games[indexPath.row]
        }
    }

}