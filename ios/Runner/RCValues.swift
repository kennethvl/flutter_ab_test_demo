//
//  RCValues.swift
//  Runner
//
//  Created by Kenneth Vincent on 7/16/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Firebase
import UIKit

class RCValues: NSObject {
    static let sharedInstance = RCValues()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private override init() {
        super.init()
        self.loadDefaultValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            "first_text": "Test",
            "second_color": "#55CC03",
            "first_button_text": "Go to First Detail",
            "second_button_action": "second",
        ]
        
        remoteConfig.setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        self.remoteConfig.configSettings = debugSettings
    }
    
    func fetchCloudValues() {
        let fetchDuration: TimeInterval = 0
        
        remoteConfig.fetch(withExpirationDuration: fetchDuration) { _, _ in
            RemoteConfig.remoteConfig().activate(completionHandler: nil)
            print("Retrieved values from the cloud!")
        }
        self.activateDebugMode()
    }
    
    static func getValueFor(key: String) -> String {
        print("key \(key)")
        return RemoteConfig.remoteConfig().configValue(forKey: key).stringValue ?? "undefined"
    }
}
