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
            return ("date scheduled: \(dateScheduled!.description(with: .autoupdatingCurrent))")
        }
        if timeInterval != nil {
            return ("time interval scheduled:  \(timeInterval!.description) mins")
        }
        if let location = location {
            return ("location scheduled:  latitude \(location.coordinate.latitude), longitude \(location.coordinate.longitude)")
        } else {
            return "No Location"
        }
    }
}
