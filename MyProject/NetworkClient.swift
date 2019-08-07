//
//  NetworkClient.swift
//  MyProject
//
//  Created by Dev on 07/08/2019.
//  Copyright © 2019 Dev. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkClient : NSObject {
    lazy var users : Array = {
        return [User]()
    }()
    func downloadUser (complete : @escaping DownloadComplete){
        Alamofire.request(Constants.API_URL.rawValue).responseObject{
            (response : DataResponse<UserResponse> ) in
            let list  = response.result.value
            
             if let userModel = list?.users {
                for (_ , user) in userModel.enumerated() {
                    self.users.append(user)
                }
            }
            complete()
        }
    }
}
