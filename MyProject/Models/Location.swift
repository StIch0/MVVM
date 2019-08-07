//
//  Location.swift
//  MyProject
//
//  Created by Dev on 01/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class Location : Mappable{
    var street: String!
    var city: String!
    var state: String!
    var postalcode: Int!
    var coordinates: Coordinates!
    var timezone: Timezone!
    required init?(map: Map) {
        
    }
      func mapping(map: Map) {
        street<-map["street"]
        city<-map["city"]
        state<-map["state"]
        postalcode<-map["postalcode"]
        coordinates<-map["coordinates"]
        timezone<-map["timezone"]
    }
}
