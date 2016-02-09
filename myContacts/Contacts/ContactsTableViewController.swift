//
//  ContactsTableViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
            loggedIn = true
        }
    }
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        
    }
    
}
