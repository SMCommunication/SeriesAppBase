//
//  Config.swift
//  SeriesAppBase
//
//  Created by shogo okamuro on 5/16/16.
//  Copyright © 2016 shogo okamuro. All rights reserved.
//

import UIKit

class Config {
    static let plistPath = "API"
    
    
    static func plist(property:String)->String{
        if let path = NSBundle.mainBundle().pathForResource(Config.plistPath, ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path)
            if let string = dict?.valueForKey(property) as? String {
                return string
            }
        }
        return ""
    }
    
    
}
