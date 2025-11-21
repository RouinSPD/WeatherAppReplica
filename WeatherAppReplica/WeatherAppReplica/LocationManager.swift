//
//  LocationManager.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 01/05/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

/// A class responsible for managing location updates and reverse geocoding.
///
/// `LocationManager` uses `CLLocationManager` to retrieve the user's current location
/// and performs reverse geocoding to obtain the city name.
///
/// - Important: This class inherits from `NSObject` to conform to `CLLocationManagerDelegate`,
/// and from `ObservableObject` so it can be used with SwiftUI views.
class LocationManager: NSObject, ObservableObject {
    
    /// The current location of the user.
    @Published var currentLocation: CLLocation?
    
    /// The name of the city retrieved via reverse geocoding.
    @Published var cityName: String?
    
    /// Internal CLLocationManager instance used to request location data.
    private let locationManager = CLLocationManager()
    
    /// Internal CLGeocoder instance used for reverse geocoding.
    private let geocoder = CLGeocoder()  // For reverse geocoding
    
    /// Initializes a new instance of `LocationManager`.
    ///
    /// This sets up the desired accuracy, distance filter, authorization request,
    /// and sets the delegate to receive location updates.
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Minimum distance (in meters) before update
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    /// Starts updating the user's location.
    ///
    /// Call this when you want to begin receiving location updates.
    func requestLocation() {
        locationManager.startUpdatingLocation()
    }
    
    /// Stops updating the user's location.
    ///
    /// Call this to stop receiving location updates and conserve battery.
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    /// Performs reverse geocoding to obtain the city name from a given location.
    ///
    /// - Parameter location: The location to reverse geocode.
    private func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                if let placemark = placemarks?.first, let cityName = placemark.locality {
                    self?.cityName = cityName
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate{
    
    /// Tells the delegate that new location data is available.
    ///
    /// This method is called when the `CLLocationManager` provides new location updates.
    /// It compares the most recent location with the last saved location and only updates
    /// the `currentLocation` property if:
    /// - There is no previously stored location.
    /// - The device has moved at least 500 meters from the last recorded location.
    ///
    /// If a valid location update is accepted, it also performs reverse geocoding to retrieve
    /// a human-readable city name.
    ///
    /// - Parameters:
    ///   - manager: The location manager object delivering the update.
    ///   - locations: An array of `CLLocation` objects containing the location data. The last object is the most recent.
    ///
    /// - Note:
    ///   Uses `DispatchQueue.main.async` to ensure UI-bound properties are updated on the main thread.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        // If no previous location is stored, accept this one
        guard let lastLocation = currentLocation else {
            DispatchQueue.main.async {
                self.currentLocation = newLocation
            }
            reverseGeocode(location: newLocation)
            return
        }
        
        // Compare new location with the previous one
        let distance = newLocation.distance(from: lastLocation) // distance in meters
        
        if distance >= 500 { // Only update if moved more than 500 meters
            DispatchQueue.main.async {
                self.currentLocation = newLocation
            }
            reverseGeocode(location: newLocation)
        }
    }
    
    /// Called when the location manager fails with an error.
    ///
    /// - Parameter error: The error that occurred.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}
