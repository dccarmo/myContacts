//
//  Contact.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

struct Contact {
    
    let imageUrl: String
    let homePage: String
    let emails: [Email]
    let name: String
    let position: String
    let addresses: [Address]
    let companyDetails: Company
    let age: Int16
    let phones: [Phone]
    
    /**
     Fetches all Contacts from the static URL
     
     - returns: Observable with Progress and an array of Contacts as types
     */
    
    static func fetchAll() -> Observable<(Float, [Contact]?)> {
        return Observable.create({
            (observer) -> Disposable in
            Alamofire.request(.GET, "http://beta.json-generator.com/api/json/get/4yLVmeGYe").progress({
                (bytesRead, totalBytesRead, totalBytesExpectedToRead) -> Void in
                
                observer.onNext((Float(totalBytesRead/totalBytesExpectedToRead), nil))
                
                return
                
            }).responseJSON {
                (response) -> Void in
                if let resultValue = response.result.value {
                    let jsonObject = JSON(resultValue)
                    var contacts = [Contact]()
                    
                    for contactJsonObject in jsonObject.arrayValue {
                        contacts.append(Contact.parseJSON(contactJsonObject))
                    }
                    
                    observer.onNext((1,contacts))
                    observer.onCompleted()
                    
                    return
                }
                
                observer.onError(response.result.error!)
            }
            
            return AnonymousDisposable {}
        })
    }
    
}

extension Contact: JSONParseable {
    
    static func parseJSON(contactJsonObject: JSON) -> Contact {
        var emails = [Email]()
        
        for emailJsonObject in contactJsonObject["emails"].arrayValue {
            emails.append(Email.parseJSON(emailJsonObject))
        }
        
        var phones = [Phone]()
        
        for phoneJsonObject in contactJsonObject["phone"].arrayValue {
            phones.append(Phone.parseJSON(phoneJsonObject))
        }
        
        var addresses = [Address]()
        
        for addressJsonObject in contactJsonObject["address"].arrayValue {
            addresses.append(Address.parseJSON(addressJsonObject))
        }
        
        return Contact(
            imageUrl: contactJsonObject["imageUrl"].stringValue,
            homePage: contactJsonObject["homePage"].stringValue,
            emails: emails,
            name: contactJsonObject["name"].stringValue,
            position: contactJsonObject["position"].stringValue,
            addresses: addresses,
            companyDetails: Company.parseJSON(contactJsonObject["companyDetails"]),
            age: contactJsonObject["age"].int16Value,
            phones: phones)
    }
    
}