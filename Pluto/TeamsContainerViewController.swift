//
//  TeamsContainerViewController.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class TeamsContainerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AcceptCellDelegate, DenyCellDelegate {
        
    @IBOutlet weak var myTeamsTableView: UITableView!
    @IBOutlet weak var myInvitesTableView: UITableView!
    
    var invites: Invites = []
    var teams: Teams = []
    var teamToShow: Team?
    
    var user: User? {
        didSet {
            if user == nil {
                teams = []
                invites = []
                myTeamsTableView.reloadData()
                myInvitesTableView.reloadData()
            }
        }
    }
    
    let teamDataProvider = TeamDataProvider()
    let inviteDataProvider = InviteDataProvider()
    
    let model = TeamModel()
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTeamsTableView.delegate = self
        self.myTeamsTableView.dataSource = self
        self.myInvitesTableView.delegate = self
        self.myInvitesTableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    private func getData() {
        userModel.getUser({ (user) in
            self.user = user
            
            self.teamDataProvider.findTeamsByUser(user, completionHandler: { (teams) in
                self.teams = teams
                self.myTeamsTableView.reloadData()
            })
            
            self.inviteDataProvider.findInvitesByUser(user, completionHandler: { (invites) in
                self.invites = invites
                self.myInvitesTableView.reloadData()
            })
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == myTeamsTableView ? teams.count + 1 : invites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == myTeamsTableView {
            switch indexPath.row {
            case 0: return tableView.dequeueReusableCellWithIdentifier("createANewTeamCell", forIndexPath: indexPath)
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("teamCell", forIndexPath: indexPath)
                
                cell.textLabel!.text = teams[indexPath.row - 1].name
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("inviteCell", forIndexPath: indexPath) as! InviteCell
            
            if cell.acceptCellDelegate == nil {
                cell.acceptCellDelegate = self
            }
            
            if cell.denyCellDelegate == nil {
                cell.denyCellDelegate = self
            }
            
            cell.teamName!.text = invites[indexPath.row].teamName
            cell.sender!.text = invites[indexPath.row].sender
                
            return cell

        }
    }
    
    func acceptCellTapped(cell: InviteCell) {
        model.acceptInvite(invites[myInvitesTableView.indexPathForCell(cell)!.row])
        getData()
    }
    
    func denyCellTapped(cell: InviteCell) {
        model.denyInvite(invites[myInvitesTableView.indexPathForCell(cell)!.row])
        getData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == myTeamsTableView {
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("createATeamSegue", sender: self)
            default:
                teamToShow = teams[indexPath.row - 1]
            }
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
