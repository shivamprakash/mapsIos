//
//  DataManager.swift
//  map
//
//  Created by student on 2/8/15.
//  Copyright (c) 2015 student. All rights reserved.
//

import Foundation
let apiUrl = "http://localhost/~student/stops1.json"

class DataManger{
    //Example from http://www.raywenderlich.com/82706/working-with-json-in-swift-tutorial
    
    class func getDataFromURLWithSuccess(success: ((appData: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: apiUrl)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(appData: urlData)
            }
        })
    }
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}