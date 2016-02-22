//
//  LocationService+UpdateStopTimer.swift
//
//
//  Created by William Falcon on 6/17/15.
//  Copyright (c) 2015 William Falcon. All rights reserved.
//

import Foundation
import CoreLocation


extension LocationService {
    
    func startUpdatingLocation() {
        updateCount = 0
        
        //invalidate any timers so we know for sure in n seconds it will stop
        self.locationTimer?.invalidate()
        
        if canAccessLocation() {
            locationManager.startUpdatingLocation()
            print("LocationService: Updating location")
            launchStopUpdatingTimer()
        }
            
        else {
            requestPermissionToAccessLocation()
        }
    }
    
    ///Starts timer which will stop location updates when it fires
    func launchStopUpdatingTimer() {
        self.locationTimer = NSTimer.scheduledTimerWithTimeInterval(LOCATION_STOP_TIMER_LENGTH_IN_SECONDS, target: self, selector: "stopUpdatingLocation", userInfo: nil, repeats: true)
    }
    
    
    ///When requested to stop kill the manager and invalidate any timers that were active
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        self.locationTimer?.invalidate()
        print("location manager stopped")
        callCompleteBlockWithLocation(lastKnownLocation)
    }
    
    private func callCompleteBlockWithLocation(location: CLLocation?) {
        
        if let loc = location {
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            let accuracy = loc.horizontalAccuracy
            completeBlock?(latitude: lat, longitude: lon, accuracy: accuracy)
            
            //Print the new coordinates
            print("\nLocationService: Final location:\nLat \(lat)\nLon \(lon)\nAccuracy:\(accuracy)\n")
        }
    }
}
