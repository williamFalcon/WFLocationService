//
//  LocationService+Utils.swift
//  
//
//  Created by William Falcon on 6/17/15.
//  Copyright (c) 2015 William Falcon. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension LocationService {
    
    ///Asks user for permission to access location
    func requestPermissionToAccessLocation() {
        
        //request permission
        if isMinimumiOS8() {
            println("\nLocationService: Requesting Authorization... If nothing happens, add the NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription key to your info.plist\n")
            
            locationManager.requestWhenInUseAuthorization()
        }else {
            self.startUpdatingLocation()
        }
    }
    
    func canAccessLocation() -> Bool {
        var canAccessLocation = CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse)
        return canAccessLocation
    }
    
    ///Returns true if current device has iOS 8+
    private func isMinimumiOS8() -> Bool{
        var version:NSString = UIDevice.currentDevice().systemVersion as NSString
        return version.doubleValue >= 8
    }
}