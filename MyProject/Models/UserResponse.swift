//
//  UserResponse.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse :Mappable{
    var users: Array<User>!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        users<-map["results"]
    }
}
