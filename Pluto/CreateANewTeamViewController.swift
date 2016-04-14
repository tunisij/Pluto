//
//  CreateANewTeamViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class CreateANewTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var friends: Users = []
    
    let userModel = UserModel()
    let teamModel = TeamModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        friends.removeAll()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath)
                
        cell.textLabel!.text = friends[indexPath.row].username
        cell.detailTextLabel!.text = friends[indexPath.row].email
        
        return cell

    }
    
    @IBAction func inviteButtonClicked(sender: AnyObject) {
        userModel.getUserByEmail(self.emailTextField.text, completionHandler: { (user) in
            if user == nil {
                return
            }
            
            for friend in self.friends {
                if friend.uid == user!.uid {
                    return
                }
            }
            
            self.friends.append(user!)
            self.tableView.reloadData()
        })
    }
    
    @IBAction func submitButtonClicked(sender: AnyObject) {
        self.teamModel.persist(self.nameTextField.text!, friends: friends, parent: self)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}