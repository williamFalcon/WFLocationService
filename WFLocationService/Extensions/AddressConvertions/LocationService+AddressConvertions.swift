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
    
    ///Returns an address from a location using Apple geocoder
    func addressFromLocation(location:CLLocation!, completionClosure:((NSDictionary?)->())){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) -> Void in
                if let places = placeMarks {
                    let marks = places[0] 
                    completionClosure(marks.addressDictionary)
                }else {
                    completionClosure(nil)
                }
                
            })
        })
    }
    
    ///Returns a location from a given address using google API
    func locationFromAddress(address: String, successClosure success:((latitude:Double, longitude:Double)->()), failureClosure failure:(()->())){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            // assemble request
            //let addressNS:NSString = address as NSString
            //let range = NSRange(location: 0, length: addressNS.length)
            
            // Replace white spaces with plus signs
            //let escapedAddress = addressNS.stringByReplacingOccurrencesOfString(" ", withString: "+")
            
            //TODO: move API keys out of class
            //let requestURL = "https://maps.googleapis.com/maps/api/geocode/json?address=\(escapedAddress)&key=\(self.GOOGLE_PLACES_API_KEY)"
            
            /*
            // Place request
            WFHttp.GET(requestURL, optionalParameters: nil, optionalHTTPHeaders: nil, completion: { (result, statusCode, response) -> Void in
                
                if statusCode == 200 { // success
                    
                    if result.count > 0 {
                        let (lat, lon) = googlePlacesLocationJSONToCoordinates(result as! NSDictionary)
                        success(latitude: lat as! Double, longitude: long as! Double)
                        
                    }
                    else {
                        failure()
                    }
                }else {
                    failure()
                }
            })*/
            
        })
    }
    
    ///Extracts the coordinates from google places API
    private func googlePlacesLocationJSONToCoordinates(json:NSDictionary) -> (lat:Double?, lon:Double?) {
        
        // get result
        let results = json.objectForKey("results") as! NSArray
        let geomResult = results.objectAtIndex(0) as! NSDictionary
        let geometry = geomResult.valueForKey("geometry") as! NSDictionary
        let location = geometry.valueForKey("location") as! NSDictionary
        
        let lat = location.valueForKey("lat") as? NSNumber
        let lon = location.valueForKey("lng") as? NSNumber
        return (lat:lat?.doubleValue, lon:lon?.doubleValue)
    }
    
}