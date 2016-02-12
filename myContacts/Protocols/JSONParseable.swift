//
//  JSONParseable.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/10/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

// Nice to have Protocol that helps separates which object can be created from a JSON object

protocol JSONParseable {
    
    static func parseJSON(jsonObject: JSON) -> Self
    
}