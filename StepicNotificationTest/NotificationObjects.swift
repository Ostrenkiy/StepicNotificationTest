//
//  NotificationObjects.swift
//  StepicNotificationTest
//
//  Created by Alexander Karpov on 31.05.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import Foundation

struct NotificationObjects {
    
    private static func loadObjectWithKey(key: String) -> String {
        let path = NSBundle.mainBundle().bundlePath
        let scriptsPlistPath = "\(path)/NotificationText.plist"
        let plistData = NSDictionary(contentsOfFile: scriptsPlistPath)!
        return plistData[key] as! String
    }
    
    static var  learn : String {
        return loadObjectWithKey(learnObjectKey)
    }
    
    private static var learnObjectKey : String = "LearnObject"
    
}