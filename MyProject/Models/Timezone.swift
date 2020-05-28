//
//  Timezone.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
struct Timezone: Mappable{
    var offset: String!
    var descriptionZone: String!
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        offset<-map["offset"]
        descriptionZone<-map["description"]
    }
}
