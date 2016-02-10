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
//    let address: Address
//    let companyDetails: Company
    let age: Int16
    let phone: [Phone]
    
    static func getAll() -> Observable<(Float, [Contact]?)> {
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
        return Contact(imageUrl: contactJsonObject["imageUrl"].stringValue, homePage: contactJsonObject["homePage"].stringValue, emails: [], name: contactJsonObject["name"].stringValue, position: contactJsonObject["position"].stringValue, age: contactJsonObject["age"].int16Value, phone: [])
    }
    
}