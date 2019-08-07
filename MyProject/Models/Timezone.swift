//
//  Timezone.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class Timezone: Mappable{
    var offset: String!
    var description: String!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        offset<-map["offset"]
        description<-map["description"]
    }
}
