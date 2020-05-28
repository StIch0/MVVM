//
//  Login.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
struct Login: Mappable {
    var uuid: String!
    var username: String!
    var password: String!
    var salt: String!
    var md5: String!
    var sha1: String!
    var sha256: String!
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        uuid<-map["uuid"]
        username<-map["username"]
        password<-map["password"]
        salt<-map["salt"]
        md5<-map["md5"]
        sha1<-map["sha1"]
        sha256<-map["sha256"]
    }
}
