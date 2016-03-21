//
//  InviteCellPrototype.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class InviteCell: UITableViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var sender: UILabel!
    
    var acceptCellDelegate: AcceptCellDelegate?
    var denyCellDelegate: DenyCellDelegate?
    
    @IBAction func acceptButtonClicked(sender: AnyObject) {
        if let delegate = acceptCellDelegate {
            delegate.acceptCellTapped(self)
        }
    }
    
    @IBAction func denyButtonClicked(sender: AnyObject) {
        if let delegate = denyCellDelegate {
            delegate.denyCellTapped(self)
        }
    }
    
}