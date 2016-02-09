//
//  StoryboardIdentifiable.swift
//
//
//  Created by Diogo Carmo on 2/3/16.
//  Copyright © 2016 All rights reserved.
//

import Foundation

protocol StoryboardIdentifiable {
    
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
    static var leadingSegue: String { get }
    
}

extension StoryboardIdentifiable {
    
    static var storyboardName: String {
        fatalError("\(String(self)) didn't override 'storyboardName'")
    }
    
    static var storyboardIdentifier: String {
        return String(self)
    }
    
    static var leadingSegue: String {
        return "to" + String(self)
    }
    
}