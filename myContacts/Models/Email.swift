//
//  Email.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation

struct Email {
    
    enum Label: String {
        case Personal = "Personal"
        case Work = "Work"
    }
    
    let email: String
    let label: Label
    
}