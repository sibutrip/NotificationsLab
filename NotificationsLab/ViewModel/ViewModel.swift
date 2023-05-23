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
    
    var location: CLLocation? {
        locationManager.location
    }
    
    func scheduleNotification() {
        // TODO: schedule the local notifications: 1- Calendar notification, 2- Time interval notification 3- Location notification.
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
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



