//
//  ContactDetailViewModel.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class ContactDetailViewModel: NSObject {
    
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
        super.init()
    }
    
}

extension ContactDetailViewModel: UITableViewDataSource {
    
    enum Section: Int {
        case Phones = 0
        case Emails = 1
        case HomePage = 2
        case CompanyDetails = 3
        case Position = 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .Phones:
            return self.contact.phones.count
            
        case .Emails:
            return self.contact.emails.count
            
        case .HomePage, .CompanyDetails, .Position:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .Phones:
            return "Phones"
            
        case .Emails:
            return "Emails"
            
        case .HomePage:
            return "Home Page"
            
        case .CompanyDetails:
            return "Company Details"
            
        case .Position:
            return "Position"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        switch Section(rawValue: indexPath.section)! {
        case .Phones:
            tableViewCell.textLabel!.text = self.contact.phones[indexPath.row].type.rawValue
            tableViewCell.detailTextLabel!.text = self.contact.phones[indexPath.row].number
            
        case .Emails:
            tableViewCell.textLabel!.text = self.contact.emails[indexPath.row].label.rawValue
            tableViewCell.detailTextLabel!.text = self.contact.emails[indexPath.row].email
            
        case .HomePage:
            tableViewCell.textLabel!.text = self.contact.homePage
            
        case .CompanyDetails:
            tableViewCell.textLabel!.text = self.contact.companyDetails.name
            tableViewCell.detailTextLabel!.text = self.contact.companyDetails.location
            
        case .Position:
            tableViewCell.textLabel!.text = self.contact.position
        }
        
        return tableViewCell
    }
    
}
