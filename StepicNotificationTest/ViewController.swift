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

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func sendButtonPressed(_ sender: NSButton) {
        sendMessage(getRegToken())
    }
    
    func sendMessage(_ to: String) {
        // Create the request.
        let request = NSMutableURLRequest(url: URL(string: sendUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(getApiKey())", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 60
        
        // prepare the payload
        let message = getMessage(to)
        let jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: message, options: [])
            request.httpBody = jsonBody!
            NSURLConnection.sendAsynchronousRequest(
                request as URLRequest,
                queue: OperationQueue.main,
                completionHandler: {
                    (response: URLResponse?, data: Data?, error: Error?) -> Void in
                    if error != nil {
                        NSAlert(error: error!).runModal()
                    } else {
                        print("Success! Response from the GCM server:")
                        print(response)
                    }
                }
            )
        } catch let error as NSError {
            NSAlert(error: error).runModal()
        }
        
    }
    
    func getMessage(_ to: String) -> NSDictionary {
        return ["to": to,
                "notification" : [
                    "sound" : "",
                    "badge" : "0",
                    "content_available" : true],
                "priority" : "high"]
    }
    
    func getApiKey() -> String {
        return "AIzaSyBUKsA9GLHhYQ31fu2OPKGOypwMR9SE-6U"
        return apiKeyTextField.stringValue.replacingOccurrences(of: "\n", with: "")
    }
    
    func getRegToken() -> String {
        return "cMi6Ja1glgc:APA91bEP4l4Wcak8rmiYHEa6P2Vqr4zVcpaWbYyALunmISglHRgls8ZbJCwugUFo6rv1QVvnlbaIeQ5VvdqqEi4KHXfEhKcHcVOlRaicZDsGHp8-8-YkQwAlmHSTgwnwO05CX8YDYaZq"
        return registrationIdTextField.stringValue.replacingOccurrences(of: "\n", with: "")
    }
    
}

