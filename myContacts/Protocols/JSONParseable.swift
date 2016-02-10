//
//  JSONParseable.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/10/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONParseable {
    
    static func parseJSON(JSON: JSON) -> Self
    
}