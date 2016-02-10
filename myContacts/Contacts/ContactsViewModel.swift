//
//  ContactsViewModel.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit
import RxSwift

class ContactsViewModel: NSObject {
    
    var contacts = [Contact]()
    var filteredContacts: [Contact]?
    
    func updateContacts() -> Observable<Float> {
        return Observable.create({
            (observer) -> Disposable in
            
            _ = Contact.fetchAll().subscribeNext({
                [weak self] (update) -> Void in
                if update.0 < 1 {
                    observer.onNext(update.0)
                    
                } else if update.1 != nil {
                    observer.onNext(1)
                    self!.contacts = update.1!
                    observer.onCompleted()
                }
            })
            
            return AnonymousDisposable {}
        })
    }
    
    func filterContactsWithSearchText(searchText: String) {
        if searchText.characters.count == 0 {
            self.filteredContacts = nil
            
        } else {
            self.filteredContacts = self.contacts.filter({
                (contact) -> Bool in
                return contact.name.lowercaseString.containsString(searchText.lowercaseString)
            })
        }
    }
    
}

extension ContactsViewModel: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredContacts != nil ? self.filteredContacts!.count : self.contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var contact: Contact
        
        if self.filteredContacts != nil {
            contact = self.filteredContacts![indexPath.row]
            
        } else {
            contact = self.contacts[indexPath.row]
        }
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        tableViewCell.textLabel!.text = contact.name
        
        return tableViewCell
    }
    
}

extension ContactsViewModel: SegueProcessable {
    
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == ContactDetailTableViewController.leadingSegue {
            let contactsTableViewConotroller = segue.sourceViewController as! ContactsTableViewController
            let indexPath = contactsTableViewConotroller.tableView.indexPathForSelectedRow!
            
            var contact: Contact
            if self.filteredContacts != nil {
                contact = self.filteredContacts![indexPath.row]
                
            } else {
                contact = self.contacts[indexPath.row]
            }
            
            let contactDetailViewController = segue.destinationViewController as! ContactDetailTableViewController
            contactDetailViewController.viewModel = ContactDetailViewModel(contact: contact)
        }
    }
    
}
