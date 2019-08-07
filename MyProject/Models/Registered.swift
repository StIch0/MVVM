//
//  Registered.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

class Registered: Mappable {
    var date: String!
    var age: Int!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        date<-map["date"]
        age<-map["age"]
    }
}
