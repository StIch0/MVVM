//
//  User.swift
//  MyProject
//
//  Created by Dev on 01/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class User: Mappable {
    var gender: String!
    var name: Name!
    var location: Location!
    var email: String!
    var login: Login!
    var dob: Dob!
    var registered:Registered!
    var phone: String!
    var cell: String!
    var id: Id!
    var picture: Picture!
    var nat: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        gender<-map["gender"]
        name<-map["name"]
        location<-map["location"]
        email<-map["email"]
        dob<-map["dob"]
        registered<-map["registered"]
        phone<-map["phone"]
        cell<-map["cell"]
        id<-map["id"]
        picture<-map["picture"]
        nat<-map["nat"]
    }
    
    
}
