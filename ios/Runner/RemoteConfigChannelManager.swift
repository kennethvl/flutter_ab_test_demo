//
//  RemoteConfigChannelManager.swift
//  Runner
//
//  Created by Kenneth Vincent on 7/16/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit

class RemoteConfigChannelManager: NSObject {
    private let methodChannel: FlutterMethodChannel
    private let flutterVC: FlutterViewController

    internal init(vc: FlutterViewController) {
        self.flutterVC = vc
        self.methodChannel = FlutterMethodChannel(name: "ab-test", binaryMessenger: self.flutterVC)
    }

    internal func setup() {
        self.methodChannel.setMethodCallHandler { call, result in
            switch call.method {
            case "fetchFirstText":

                guard let detail = call.arguments as? [String: Any], let key = detail["key"] as? String else {
                    break
                }

                result(RCValues.getValueFor(key: key))
            default:
                break
            }
        }
    }
}
