//
//  LocationService+AddressConvertions.swift
//
//
//  Created by William Falcon on 6/17/15.
//  Copyright (c) 2015 William Falcon. All rights reserved.
//

import Foundation
import CoreLocation

extension LocationService {
    
    ///Defaulted to 30 meters. Set here to update
    class func setLocationAccuracy(#meters:Double) {
        LocationService.sharedInstance.LOCATION_ACCURACY = meters
    }
    
    //Defaulted to 10 seconds. Set here to update
    class func setLocationUpdateTimeLimit(#seconds:Double) {
        LocationService.sharedInstance.LOCATION_STOP_TIMER_LENGTH_IN_SECONDS = seconds
    }
    
    
    /**
    Gets current location.
    
    Handles requesting location permissions.
    Handles stopping the location manager automatically
    
    :param: progress Can be called multiple times when a more accurate location is available.
    :param: complete Called once timer expires with the most accurate location found
    :param: failure Called if something fails
    */
    class func getCurrentLocationWithProgress(progress:((latitude:Double, longitude:Double)->()), onComplete complete:((latitude:Double, longitude:Double, accuracy:Double)->())?, onFailure failure:((error:NSError)->())?) {
        
        var manager = LocationService.sharedInstance
        
        //will be called when a better location is found
        manager.progressBlock = progress
        
        //Called when timer expires
        manager.completeBlock = complete
        
        //called on failure
        manager.failUpdateBlock = failure
        
        if manager.canAccessLocation() {
            manager.startUpdatingLocation()
        }else {
            manager.requestPermissionToAccessLocation()
        }
    }
}