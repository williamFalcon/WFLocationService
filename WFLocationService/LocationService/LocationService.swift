//
//  LocationService.swift
//  Hac Studios
//
//  Created by William Falcon on 9/3/14.
//  Copyright (c) 2014 HACStudios. All rights reserved.
//
//  Provides simple functionality to get the current location of the device
//
//  IMPORTANT: If init doesn't work (ask for a prompt or show location), then add the two keys to info.plist
//  NSLocationWhenInUseUsageDescription AND NSLocationAlwaysUsageDescription


import Foundation
import CoreLocation

let _locationServiceSingletonInstance = LocationService()
class LocationService: NSObject {
    
    //Used to get a location from an address
    let GOOGLE_PLACES_API_KEY = "000000000000000000"
    
    //desired accuracy
    var LOCATION_ACCURACY : Double = 30.0
    
    //Location updates will end at this time
    var LOCATION_STOP_TIMER_LENGTH_IN_SECONDS : Double = 10.0
    var locationTimer : NSTimer?
    
    //tracks last location and # of location updates
    var lastKnownLocation : CLLocation?
    var updateCount = 0
    var progressBlock : ((latitude:Double, longitude:Double)->())?
    var completeBlock : ((latitude:Double, longitude:Double, accuracy:Double)->())?
    var failUpdateBlock : ((error:NSError)->())?
    
    //Location management
    var locationManager = CLLocationManager()
    
    //Singleton
    class var sharedInstance: LocationService {
        return _locationServiceSingletonInstance
    }
    
    /*
    Convenience accessor to the last location
    */
    class func lastLocation() -> CLLocationCoordinate2D{
        var manager = LocationService.sharedInstance
        let lastKnown = manager.lastKnownLocation
        return lastKnown!.coordinate
    }
    
    override init() {
        super.init()
        
        //config the location manager
        locationManager.delegate = self
        locationManager.distanceFilter = LOCATION_ACCURACY
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}



