//
//  AnalyticsManager.swift
//  Runner
//
//  Created by Kenneth Vincent on 7/9/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Mixpanel
import UIKit

class AnalyticsManager: NSObject {
    static let mixpanelStaging = Mixpanel.getInstance(name: "Mixpanel Development")
    
    internal static func trackEvent(name: String) {
        mixpanelStaging?.track(event: name)
    }
    
    internal static func trackEvent(name: String, properties: [String: Any]) {
        let mixpanelProperties = self.convertToMixpanelProperties(prop: properties)
        
        print("event name \(name) prop \(properties)")
        
        mixpanelStaging?.track(event: name, properties: mixpanelProperties)
    }
    
    internal static func indentifyUser(phone: String) {
        mixpanelStaging?.identify(distinctId: phone)
    }
    
    private static func convertToMixpanelProperties(prop: [String: Any]) -> Properties {
        var props: Properties = [:]
        
        prop.forEach { key, value in
            switch value {
            case let someString as String:
                props[key] = someString
            case let someInt as Int:
                props[key] = someInt
            case let someUInt as UInt:
                props[key] = someUInt
            case let someDouble as Double:
                props[key] = someDouble
            case let someFloat as Float:
                props[key] = someFloat
            case let someBool as Bool:
                props[key] = someBool
            case let someDate as Date:
                props[key] = someDate
            case let someURL as URL:
                props[key] = someURL
            default:
                props[key] = "\(value)"
            }
        }
        
        return props
    }
}
