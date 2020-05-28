//
//  Name.swift
//  MyProject
//
//  Created by Dev on 01/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
struct Name : Mappable{
    var title: String!
    var first: String!
    var last: String!
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        first <- map["first"]
        last <- map["last"]
    }
    
    
}
