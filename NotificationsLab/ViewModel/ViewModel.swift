//
//  ViewModel.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import Foundation
import CoreLocation
import MapKit

enum NotificationSelection: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case date, timer, location
}

@MainActor
class ViewModel: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var notifications: [Notification] = []
    
    @Published var notificatonSelected = NotificationSelection.date
    
    @Published var scheduleOnADate = false
    @Published var date = Date()
        
    @Published var scheduleAtAnInterval = false
    @Published var timeInterval = Int()
    
    @Published var scheduleAtALocation = false
    @Published var mapArea = MKMapRect()
    
    var location: CLLocation? {
        locationManager.location
    }
    
    func scheduleNotification() {
//        switch daEnum {
//            calendarNotification()
//            timernotificaitowengoiewf()
//            the other one()
//        }
        // TODO: schedule the local notifications: 1- Calendar notification, 2- Time interval notification 3- Location notification.
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
    }
    
    func requestLocation () {
        locationManager.requestWhenInUseAuthorization()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}



