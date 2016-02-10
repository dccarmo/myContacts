//
//  Email.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Email {
    
    enum Label: String {
        case Personal = "Personal"
        case Work = "Work"
    }
    
    let email: String
    let label: Label
    
}

extension Email: JSONParseable {
    
    static func parseJSON(emailJsonObject: JSON) -> Email {
        return Email(
            email: emailJsonObject["email"].stringValue,
            label: Label(rawValue: emailJsonObject["label"].stringValue)!)
    }
    
}