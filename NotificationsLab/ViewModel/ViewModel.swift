//
//  ViewModel.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import Foundation
import CoreLocation
import MapKit

@MainActor
class ViewModel: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var activities: [Notification] = []
    
    @Published var scheduleAtATime = false
    @Published var date = Date()
    
    @Published var scheduleAtAnInterval = false
    @Published var timeInterval = Int()
    
    @Published var scheduleAtALocation = false
    @Published var mapArea = MKMapRect()
    
    func scheduleNotification() {
        // code the logic here.
    }
    
    var location: CLLocation? {
        locationManager.location
    }
    
    func createActivity(for activity: String, at date: Date, isRepeating: Bool) {
        activities.append(Notification(name: activity, dateScheduled: date, isRepeating: isRepeating))
    }
    
    func requestLocation () {
        locationManager.requestWhenInUseAuthorization()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}



