//
//  ContactDetailTableViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    var viewModel: ContactDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.viewModel
    }
    
}
