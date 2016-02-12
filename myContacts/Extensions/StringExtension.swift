//
//  StringExtension.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/10/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation

extension String {
    
    // Useful to create indexed Table View in Contacts Table View Controller
    
    var firstCharacter: String? {
        guard self.characters.first != nil else {
            return nil
        }
        
        return String(self.characters.first!)
    }
    
}