//
//  ButtonCellDelegate.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

protocol AcceptCellDelegate {
    func acceptCellTapped(cell: InviteCell)
}

protocol DenyCellDelegate {
    func denyCellTapped(cell: InviteCell)
}