//
//  Activity.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import Foundation

struct Notification: Identifiable {
    let id = UUID()
    let name: String
    let dateScheduled: Date
    let isRepeating: Bool
}
