//
//  Activity.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import Foundation
import CoreLocation

struct Notification: Identifiable {
    let id = UUID()
    var dateScheduled: Date?
    var timeInterval: Int?
    var location: CLLocation?
    var description: String {
        if dateScheduled != nil {
            return dateScheduled!.description
        }
        if timeInterval != nil {
            return timeInterval!.description
        }
        return location!.description
    }
}
