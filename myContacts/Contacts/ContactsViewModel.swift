//
//  ContactsViewModel.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit
import RxSwift

// A structure to better accomodate the Table View sections data

struct ContactsSection {
    var contacts: [Contact]
    var firstLetter: String
}

class ContactsViewModel: NSObject {
    
    var contactSections = [ContactsSection]()
    var contacts = [Contact]()
    var filteredContacts: [Contact]? // Used when the user is searching for a contact
    
    /**
     Updates the Contacts array
     
     - returns: Observable with progress
     */
    
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
                    self!.createContactsSections()
                    
                    observer.onCompleted()
                }
            })
            
            return AnonymousDisposable {}
        })
    }
    
    /**
     Just clears the Contacts and Contacts Section arrays
     */
    
    func clearContacts() {
        self.contacts.removeAll()
        self.contactSections.removeAll()
    }
    
    /**
     Function that filters the Contacts with a given text (considering only lowercase text)
     
     - parameter searchText: text that's being searched
     */
    
    func filterContactsWithSearchText(searchText: String) {
        if searchText.characters.count == 0 {
            self.filteredContacts = nil
            self.createContactsSections()
            
        } else {
            self.filteredContacts = self.contacts.filter({
                (contact) -> Bool in
                return contact.name.lowercaseString.containsString(searchText.lowercaseString)
            })
            self.createContactsSections()
        }
    }
    
    /**
     Given a Contacts array, it populates the Contacts Section array
     */
    
    private func createContactsSections() {
        var contacts: [Contact]
        
        if self.filteredContacts != nil {
            contacts = self.filteredContacts!
            
        } else {
            contacts = self.contacts
        }
        
        let sectionIndexTitles = self.createSectionIndexTitlesWithContacts(contacts)
        
        self.contactSections.removeAll()
        
        for sectionIndexTitle in sectionIndexTitles {
            self.contactSections.append(ContactsSection(
                contacts: contacts.filter({
                    (contact) -> Bool in
                    return contact.name.firstCharacter! == sectionIndexTitle
                    
                }).sort({
                    (leftContact, rightContact) -> Bool in
                    return leftContact.name < rightContact.name
                    
                }),
                firstLetter: sectionIndexTitle))
        }
        
    }
    
    /**
     Extract all the first letters from Contacts array and returns an array of first letters (important for Contacts Section)
     
     - parameter contacts: Contacts array (can be the full or filtered)
     
     - returns: Array of Strings containing the first letters
     */
    
    private func createSectionIndexTitlesWithContacts(contacts: [Contact]) -> [String] {
        var sectionIndexTitles = [String]()
        
        for contact in contacts {
            let firstLetter = contact.name.firstCharacter!.uppercaseString
            
            if !sectionIndexTitles.contains(firstLetter) {
                sectionIndexTitles.append(firstLetter)
            }
        }
        
        return sectionIndexTitles.sort()
    }
    
}

extension ContactsViewModel: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.contactSections.count
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.contactSections.map({
            (contactsSection) -> String in
            contactsSection.firstLetter
        })
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.contactSections.map({
            (contactsSection) -> String in
            contactsSection.firstLetter
        })[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactSections[section].contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contact = self.contactSections[indexPath.section].contacts[indexPath.row]
        
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
            let contact = self.contactSections[indexPath.section].contacts[indexPath.row]
            
            let contactDetailViewController = segue.destinationViewController as! ContactDetailTableViewController
            contactDetailViewController.viewModel = ContactDetailViewModel(contact: contact)
        }
    }
    
}
