//
//  NotificationObjects.swift
//  StepicNotificationTest
//
//  Created by Alexander Karpov on 31.05.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import Foundation

struct NotificationObjects {
    
    fileprivate static func loadObjectWithKey(_ key: String) -> String {
//        let path = NSBundle.mainBundle().bundlePath
//        print(path)
//        let notificationsPlistPath = "\(path)/Contents/NotificationText.plist"
//        
//        
        let notificationsPlistPath = Bundle.main.path(forResource: "NotificationText", ofType: "plist")
        print(notificationsPlistPath)
        let plistData = NSDictionary(contentsOfFile: notificationsPlistPath!)!
        return plistData[key] as! String
    }
    
    static var  learn : String {
        return loadObjectWithKey(learnObjectKey)
    }
    
    fileprivate static var learnObjectKey : String = "LearnObject"
    
}
