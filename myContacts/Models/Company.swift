//
//  Company.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Company {
    
    let location: String
    let name: String
    
}

extension Company: JSONParseable {
    
    static func parseJSON(companyJsonObject: JSON) -> Company {
        return Company(
            location: companyJsonObject["location"].stringValue,
            name: companyJsonObject["name"].stringValue)
    }
    
}