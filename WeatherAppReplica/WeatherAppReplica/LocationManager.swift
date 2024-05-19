//
//  LocationManager.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 01/05/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

class LocationManager: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var cityName: String?  // For storing the city name
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()  // For reverse geocoding

    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()  // Use requestWhenInUseAuthorization() or requestAlwaysAuthorization() based on your needs
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }

    // Reverse geocoding to get human-readable location name
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

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if currentLocation == nil {  // Only update if no current location is set
            DispatchQueue.main.async {
                self.currentLocation = location
            }
            // Optionally reverse geocode the location
            reverseGeocode(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}
