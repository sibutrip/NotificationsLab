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
    
    private func createCalendarNotification(_ notification: NotificationItem) async throws {
        // TODO: Create a calendar notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Create the DateComponents from the specified date
        let dateComponents = Calendar.current.dateComponents(in: .autoupdatingCurrent, from: date)
        
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: notification.id.uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        try await notificationCenter.add(request)
        
    }
    
    private func createTimerNotification(_ notification: NotificationItem) async throws {
        // TODO: Create a time interval notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval), repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: notification.id.uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        try await notificationCenter.add(request)
    }
    
    func createLocationNotification(_ notification: NotificationItem) async throws {
        // TODO: Create a location-based notification
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Create a CLRegion from the user's location
        let center = location!.coordinate
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Region")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: notification.id.uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        try await notificationCenter.add(request)
        
    }
    
    func cancelNotification(_ notification: NotificationItem) {
        // TODO: Cancel the scheduled notification request
        // https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app#2980216
        
        // remove the pending notification requests with the UUID of the notification
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.id.uuidString])

        notifications.removeAll {
            $0.id == notification.id
        }
    }
    
    private func requestNotificationPermission() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.alert,.sound])
    }
    
    public func scheduleNotification() async throws {
        if try await requestNotificationPermission() {
            switch notificatonSelected {
            case .date:
                let notification = NotificationItem(title: title, body: body, dateScheduled: date)
                try await createCalendarNotification(notification)
                notifications.append(notification)
            case .timer:
                let notification = NotificationItem(title: title, body: body, timeInterval: timeInterval)
                try await createTimerNotification(notification)
                notifications.append(notification)
            case .location:
                let notification = NotificationItem(title: title, body: body, location: location)
                try await createLocationNotification(notification)
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
