//
//  ContactsTableViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactsTableViewController: UITableViewController {
    
    let viewModel = ContactsViewModel()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var openMenuBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.viewModel
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
            loggedIn = true
            
        } else {
            _ = self.viewModel.updateContacts().subscribe(onNext: {
                [weak self] (progress) -> Void in
                    self!.progressView.hidden = false
                    self!.progressView.progress = progress
                
                }, onError: {
                    (error) -> Void in
                    self!.progressView.hidden = true
                    
                }, onCompleted: {
                    () -> Void in
                    self!.progressView.hidden = true
                    self!.tableView.reloadData()
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
