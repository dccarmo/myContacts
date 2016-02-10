//
//  ContactDetailTableViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit
import WebImage

class ContactDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    var viewModel: ContactDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.viewModel
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.profileImageView.sd_setImageWithURL(NSURL(string: self.viewModel.contact.imageUrl))
        self.nameLabel.text = self.viewModel.contact.name
        self.ageLabel.text = "\(self.viewModel.contact.age) years old"
    }
    
}
