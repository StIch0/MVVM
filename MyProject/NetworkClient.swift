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
import RxCocoa
import RxSwift

class NetworkClient : API {
    
    lazy var users : BehaviorRelay<[User]> = {
        return BehaviorRelay(value: [])
    }()

    func downloadUser (complete : @escaping DownloadComplete) {
        Alamofire.request(Constants.API_URL.rawValue).responseObject {
            (response : DataResponse<UserResponse> ) in
            print(Constants.API_URL.rawValue)
            let list  = response.result.value?.users
            self.users.accept(list ?? [])
            complete()
        }
    }
}
