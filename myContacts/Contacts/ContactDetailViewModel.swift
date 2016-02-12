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
    
    // Enum that organizes each section of the view (and it's order)
    
    enum Section: Int {
        case Phones = 0
        case Emails = 1
        case HomePage = 2
        case Address = 3
        case CompanyDetails = 4
        case Position = 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .Phones:
            return self.contact.phones.count
            
        case .Emails:
            return self.contact.emails.count
            
        case .Address:
            return 7
            
        case .CompanyDetails:
            return 2
            
        case .HomePage, .Position:
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
            
        case .Address:
            return "Address"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        tableViewCell.detailTextLabel!.text = ""
        
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
            switch indexPath.row {
            case 0:
                tableViewCell.textLabel!.text = "Name"
                tableViewCell.detailTextLabel!.text = self.contact.companyDetails.name
                
            case 1:
                tableViewCell.textLabel!.text = "Location"
                tableViewCell.detailTextLabel!.text = self.contact.companyDetails.location
                
            default:
                break
            }
            
        case .Position:
            tableViewCell.textLabel!.text = self.contact.position
            
        case .Address:
            switch indexPath.row {
            case 0:
                tableViewCell.textLabel!.text = "Address 1"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].address1
                
            case 1:
                tableViewCell.textLabel!.text = "Address 2"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].address2
                
            case 2:
                tableViewCell.textLabel!.text = "Address 3"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].address3
                
            case 3:
                tableViewCell.textLabel!.text = "Zipcode"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].zipcode
                
            case 4:
                tableViewCell.textLabel!.text = "City"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].city
                
            case 5:
                tableViewCell.textLabel!.text = "State"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].state
                
            case 6:
                tableViewCell.textLabel!.text = "Country"
                tableViewCell.detailTextLabel!.text = self.contact.addresses[0].country
                
            default:
                break
            }
            
        }
        
        return tableViewCell
    }
    
}
