//
//  Picture.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

class Picture: Mappable {
    var large: String!
    var medium: String!
    var thumbnail: String!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        large<-map["large"]
        medium<-map["medium"]
        thumbnail<-map["thumbnail"]
    }
}
