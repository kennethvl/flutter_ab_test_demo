//
//  MixpanelChannelManager.swift
//  Runner
//
//  Created by Kenneth Vincent on 7/16/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Mixpanel
import UIKit

class MixpanelChannelManager: NSObject {
    private let methodChannel: FlutterMethodChannel
    private let flutterVC: FlutterViewController
    
    internal init(vc: FlutterViewController) {
        Mixpanel.initialize(token: "8b6a71e4f4217f356395f0c1ebdd9e92",
                            instanceName: "Mixpanel Development")
        self.flutterVC = vc
        self.methodChannel = FlutterMethodChannel(name: "mixpanel", binaryMessenger: self.flutterVC)
    }
    
    internal func setup() {
        self.methodChannel.setMethodCallHandler { call, _ in
            switch call.method {
            case "trackFirstText":
                guard let detail = call.arguments as? [String: Any], let name = detail["name"] as? String else {
                    print("masuk guard")
                    break
                }
                
                print("lolos guard")
                
                if let properties = detail["properties"] as? [String: Any] {
                    print("masuk dongs")
                    AnalyticsManager.trackEvent(name: name, properties: properties)
                } else {
                    AnalyticsManager.trackEvent(name: name)
                }
                
            default:
                break
            }
        }
    }
}
