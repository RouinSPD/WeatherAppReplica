//
//  LocationManager.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 01/05/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

class LocationManager: NSObject, ObservableObject{
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func requestLocation() {
            locationManager.startUpdatingLocation()
        }
        
        func stopLocation() {
            locationManager.stopUpdatingLocation()
        }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else  {return}
        
        DispatchQueue.main.async{
            self.currentLocation = location
        }
    }
}
