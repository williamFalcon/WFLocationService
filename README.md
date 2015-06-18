#WFLocationService    
Simplest way to get a user's location on iOS.   
Written 100% in Swift   

##To Use
1. Include the [WFLocationService] (https://github.com/williamFalcon/WFLocationService/tree/master/WFLocationService) folder in your app. (Cocoapods coming soon).      
2. Add the [NSLocationWhenInUseUsageDescription] (https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html) or [NSLocationAlwaysUsageDescription] (https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html) key to your info.plist   

###Get a location    
- Calling this method requests location services authorization then handles result accordingly.    
- Will be called multiple times if a more accurate location is found.   
````swift
LocationService.getCurrentLocationWithProgress({ (latitude, longitude) -> () in
    //Called when a better location is available
    
    }, onComplete: { (latitude, longitude, accuracy) -> () in
        //Called when update timer expires
        
    }) { (error) -> () in
        //Called on failure
}
````    

###Change Location Accuracy  
Default is 30 meters. Change with the following code:   
````swift
var newAccuracy : Double = 10.0
LocationService.setLocationAccuracy(meters: newAccuracy)
````  
    
###Change How long LocationService looks for new locations  
Default is 10 seconds. Change with the following code:   
````swift
var stopUpdatesTimeInSeconds : Double = 5.0
LocationService.setLocationUpdateTimeLimit(seconds: stopUpdatesTimeInSeconds)
```` 
###User Location Authorization    
It will request authorization automatically. It will handle the authorization result accordingly.        

####Author    
William Falcon. will@hacstudios.com    
Feel free to contact me for iOS development inquiries.    
