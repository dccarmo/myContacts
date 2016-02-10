//
//  Address.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address {
    
    let address1: String
    let address2: String
    let address3: String
    let zipcode: String
    let country: String
    let city: String
    let state: String
    
}

extension Address: JSONParseable {
    
    static func parseJSON(addressJsonObject: JSON) -> Address {
        return Address(
            address1: addressJsonObject["address1"].stringValue,
            address2: addressJsonObject["address2"].stringValue,
            address3: addressJsonObject["address3"].stringValue,
            zipcode: addressJsonObject["zipcode"].stringValue,
            country: addressJsonObject["country"].stringValue,
            city: addressJsonObject["city"].stringValue,
            state: addressJsonObject["state"].stringValue)
    }
    
}