//
//  ViewModel+LocationDelegate.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/23/23.
//

import SwiftUI
import CoreLocation
import MapKit

extension ViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            return
        case .restricted:
            return
        case .denied:
            return
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapArea = MKMapRect(origin: MKMapPoint(locations[0].coordinate), size: MKMapSize(width: 2500, height: 2500))
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
