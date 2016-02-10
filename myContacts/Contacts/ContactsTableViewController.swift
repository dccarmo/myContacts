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
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var openMenuBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.viewModel
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
            loggedIn = true
            
        } else {
            self.reloadTableView()
        }
    }
    
    func reloadTableView() {
        _ = self.viewModel.updateContacts().subscribe(
            onError: {
                [weak self] (error) -> Void in
            
            }, onCompleted: {
                [weak self] () -> Void in
                self!.tableView.tableHeaderView = self!.searchController.searchBar
                self!.tableView.reloadData()
            })
    }
    
    @IBAction func unwindToContactsTableViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func openMenuBarButtonItem(sender: AnyObject) {
        let mainSplitViewController = self.splitViewController as! MainSplitViewController
        mainSplitViewController.toggleSideMenu()
    }
}

extension ContactsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.viewModel.filterContactsWithSearchText(text)
            self.tableView.reloadData()
        }
    }
}
