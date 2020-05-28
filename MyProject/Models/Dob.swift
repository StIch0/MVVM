//
//  Dob.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

struct Dob: Mappable {
    var date: String!
    var age: Int!

    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        date<-map["date"]
        age<-map["age"]
    }
}
