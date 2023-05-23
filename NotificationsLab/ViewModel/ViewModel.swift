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
    @Published var body = String()
    
    var location: CLLocation? {
        locationManager.location
    }
    
    private func requestNotificationPermission() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization()
    }
    
    private func createCalendarNotification(_ notification: NotificationItem) {
        // TODO: Create a calendar notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        
    }
    private func createTimerNotification(_ notification: NotificationItem) {
        // TODO: Create a time interval notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
    }
    private func createLocationNotification(_ notification: NotificationItem) {
        // TODO: Create a location-based notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
    }
    
    public func cancelNotification(_ notification: NotificationItem) {
        // TODO: Cancel the scheduled notification request
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app#2980216
        notifications.removeAll {
            $0.id == notification.id
        }
    }
    
    public func scheduleNotification() async throws {
        if try await requestNotificationPermission() {
            switch notificatonSelected {
            case .date:
                let notification = NotificationItem(title: title, body: body, dateScheduled: date)
                createCalendarNotification(notification)
                notifications.append(notification)
            case .timer:
                let notification = NotificationItem(title: title, body: body, timeInterval: timeInterval)
                createTimerNotification(notification)
                notifications.append(notification)
            case .location:
                let notification = NotificationItem(title: title, body: body, location: location)
                createLocationNotification(notification)
                notifications.append(notification)
            }
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
