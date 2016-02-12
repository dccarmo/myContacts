//
//  LogInViewModel.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import RxSwift

class LogInViewModel: NSObject {
    
    // Simulation of a log in flow
    
    func logInWithEmail(email: String, password: String) -> Observable<Bool> {
        return SessionManager.sharedInstance.logUserWithEmail(email, password: password)
    }
    
}