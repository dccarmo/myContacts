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
    
}

extension ContactsViewModel: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let contact = self.contacts[indexPath.row]
        
        tableViewCell.textLabel!.text = contact.name
        
        return tableViewCell
    }
    
}