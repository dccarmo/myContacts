//
//  Phone.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Phone {
    
    enum Type: String {
        case Phone = "Phone"
        case Mobile = "Mobile"
    }
    
    let number: String
    let type: Type
    
}

extension Phone: JSONParseable {
    
    static func parseJSON(phoneJsonObject: JSON) -> Phone {
        return Phone(
            number: phoneJsonObject["number"].stringValue,
            type: Type(rawValue: phoneJsonObject["type"].stringValue)!)
    }
    
}