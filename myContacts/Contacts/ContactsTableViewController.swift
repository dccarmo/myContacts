//
//  ContactsTableViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet weak var openMenuBarButtonItem: UIBarButtonItem!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
            loggedIn = true
            
        } else {
            _ = Contact.fetchAll().subscribeNext({
                (update) -> Void in
                if update.0 < 1 {
                    print("Progress: \(update.0)")
                    
                } else if update.1 != nil {
                    print(update.1!)
                }
            })
        }
    }
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func openMenuBarButtonItem(sender: AnyObject) {
        let mainSplitViewController = self.splitViewController as! MainSplitViewController
        mainSplitViewController.toggleSideMenu()
    }
}
