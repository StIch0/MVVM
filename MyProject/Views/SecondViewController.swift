//
//  SecondViewController.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    let remoteSettings: RemoteConfigSettings = RemoteConfigSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
        remoteSettings.minimumFetchInterval = 0
        remoteConfig.configSettings = remoteSettings
        remoteConfig.fetch { (status, error) in
            if error != nil {
                print("Error")
            } else {
                if status == .success {
                    let urlStr = self.remoteConfig.configValue(forKey: "background_image").stringValue
                    self.imageView.load(url: URL(string: urlStr!)!)
                }
            }
        }
    }
}
