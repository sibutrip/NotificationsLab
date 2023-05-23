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
            print("not determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorized always")
            self.mapArea = MKMapRect(origin: MKMapPoint(manager.location!.coordinate), size: .init(width: 2500, height: 2500))
        @unknown default:
            print("unknown")

        }
    }
}
