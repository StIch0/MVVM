//
//  Id.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

struct Id: Mappable {
    var name: String!
    var value: String!

    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        name<-map["name"]
        value<-map["value"]
    }
}
