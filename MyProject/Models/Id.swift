//
//  Id.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

class Id: Mappable {
    var name: String!
    var value: String!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        name<-map["name"]
        value<-map["value"]
    }
}
