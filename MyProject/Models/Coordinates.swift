//
//  Coordinates.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class Coordinates:Mappable{
    var latitude: String!
    var longitude: String!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        latitude<-map["latitude"]
        longitude<-map["longitude"]
    }
}
