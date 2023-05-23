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
    
    enum NotificationSelection: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case date = "Date"
        case timer = "Timer"
        case location = "Current Location"
    }
    
    private let locationManager = CLLocationManager()
    
    @Published var notifications: [NotificationItem] = []
    
    @Published var notificatonSelected = NotificationSelection.date
    
    @Published var date = Date()
    @Published var timeInterval = Int()
    @Published var mapArea = MKMapRect()
    
    @Published var title = String()
    @Published var content = String()
    
    var location: CLLocation? {
        locationManager.location
    }
    
    private func createCalendarNotification() {
        // TODO: Create a calendar notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        
        
        
    }
    private func createTimerNotification() {
        // TODO: Create a time interval notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
    }
    func createLocationNotification() {
        // TODO: Create a location-based notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
    }
    
    func cancelNotification(_ notification: NotificationItem) {
        // TODO: Cancel the scheduled notification request
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app#2980216
        notifications.removeAll {
            $0.id == notification.id
        }
    }
    
    public func scheduleNotification() {
        switch notificatonSelected {
        case .date:
            createCalendarNotification()
            notifications.append(NotificationItem(title: title, content: content, dateScheduled: date))
        case .timer:
            createTimerNotification()
            notifications.append(NotificationItem(title: title, content: content, timeInterval: timeInterval))
        case .location:
            createLocationNotification()
            notifications.append(NotificationItem(title: title, content: content, location: location))
        }
    }
    
    public func requestLocation () {
        locationManager.requestWhenInUseAuthorization()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}
