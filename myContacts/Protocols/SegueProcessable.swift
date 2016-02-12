//
//  SegueProcessable.swift
//
//
//  Created by Diogo on 2/4/16.
//  Copyright © 2016 All rights reserved.
//

import UIKit

// Indicates that the object can process segues (useful for View Models)

protocol SegueProcessable {
    
    func prepareForSegue(segue: UIStoryboardSegue)
    
}