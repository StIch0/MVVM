//
//  UserResponse.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserResponse :Mappable{
    var users: Array<User>!
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        users<-map["results"]
    }
}
