//
//  SessionManager.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/10/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import RxSwift

 // Fake Session Manager

class SessionManager: NSObject {
    
    static let sharedInstance = SessionManager()
    
    dynamic var loggedIn = false
    
    func logUserWithEmail(email: String, password: String) -> Observable<Bool> {
        return Observable.create({
            [weak self] (observer) -> Disposable in
            
            self!.loggedIn = true
            
            observer.onNext(true)
            observer.onCompleted()
            
            return AnonymousDisposable {}
        })
    }
    
    func logOut() {
        self.loggedIn = false
    }
    
}