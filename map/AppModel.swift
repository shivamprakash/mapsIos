//
//  AppModel.swift
//  map
//
//  Created by student on 2/9/15.
//  Copyright (c) 2015 student. All rights reserved.
//

import Foundation
import MapKit
class AppModel: NSObject, Printable {
    let id: Int32
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
  /*  override var description: String {
        return "Name: \(name), URL: \(appStoreURL)\n"
    }*/
    
    init(id: Int32?, name: String?, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        
        self.name = name!
        self.id = id!
        self.latitude = latitude!
        self.longitude = longitude! 
    }
}