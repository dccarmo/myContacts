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
        
        _ = SessionManager.sharedInstance.rx_observe(Bool.self, "loggedIn").subscribeNext {
            [weak self] (loggedIn) -> Void in
            if loggedIn! {
                self!.reloadTableView()
                
            } else {
                self!.clearTableView()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.viewModel.prepareForSegue(segue)
    }
    
    /**
     Reloads the Table View with new Contacts
     */
    
    func reloadTableView() {
        _ = self.viewModel.updateContacts().subscribe(
            onError: {
                [weak self] (error) -> Void in
                let alertController = UIAlertController(title: "Error while fetching contacts", message: nil, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                self!.presentViewController(alertController, animated: true, completion: nil)
                
            }, onCompleted: {
                [weak self] () -> Void in
                self!.tableView.tableHeaderView = self!.searchController.searchBar
                self!.tableView.reloadData()
            })
    }
    
    /**
     Clears the Table View removing all rows (useful when user logs out)
     */
    
    func clearTableView() {
        self.viewModel.clearContacts()
        self.tableView.tableHeaderView = nil
        self.tableView.reloadData()
    }
    
    @IBAction func openMenuBarButtonItem(sender: AnyObject) {
        let mainSplitViewController = self.splitViewController as! MainSplitViewController
        mainSplitViewController.toggleSideMenu()
    }
    
    //MARK:- UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchController.active = false
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
