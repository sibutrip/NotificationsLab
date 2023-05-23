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
            self.mapArea = MKMapRect(origin: MKMapPoint(manager.location!.coordinate), size: .init(width: 2500, height: 2500))
        @unknown default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
