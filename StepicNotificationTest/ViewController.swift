//
//  ViewController.swift
//  StepicNotificationTest
//
//  Created by Alexander Karpov on 31.05.16.
//  Copyright © 2016 Stepic. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var apiKeyTextField: NSTextField!
    @IBOutlet weak var registrationIdTextField: NSTextField!
    
    let sendUrl = "https://android.googleapis.com/gcm/send"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func sendButtonPressed(sender: NSButton) {
    }
    
    func sendMessage(to: String) {
        // Create the request.
        let request = NSMutableURLRequest(URL: NSURL(string: sendUrl)!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(getApiKey())", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 60
        
        // prepare the payload
        let message = getMessage(to)
        let jsonBody: NSData?
        do {
            jsonBody = try NSJSONSerialization.dataWithJSONObject(message, options: [])
            request.HTTPBody = jsonBody!
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                                                    completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                                                        if error != nil {
                                                            NSAlert(error: error!).runModal()
                                                        } else {
                                                            print("Success! Response from the GCM server:")
                                                            print(response)
                                                        }
            })
        } catch let error as NSError {
            NSAlert(error: error).runModal()
        }
        
    }
    
    func getMessage(to: String) -> NSDictionary {
        return ["to": to, "notification": ["body": "Hello from GCM", "sound" : "default", "badge" : "0"], "data" : ["object" : NotificationObjects.learn], "priority":"high"]
    }
    
    func getApiKey() -> String {
        return apiKeyTextField.stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
    }
    
    func getRegToken() -> String {
        return registrationIdTextField.stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
    }
    
}

