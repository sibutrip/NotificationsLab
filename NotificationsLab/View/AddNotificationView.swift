//
//  AddNotificationView.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddNotificationView: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        Form {
            Picker("Notification Type", selection: $vm.notificatonSelected) {
                ForEach(NotificationSelection.allCases) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            switch vm.notificatonSelected {
            case .date:
                DatePicker("Date", selection: $vm.date)
            case .location:
                Map(mapRect: $vm.mapArea, showsUserLocation: true)
                    .frame(height: 400)
                    .onAppear { vm.requestLocation() }
            case .timer:
                Picker("Timer", selection: $vm.timeInterval) {
                    ForEach(0...120, id: \.self) {
                        Text("\($0.description) min")
                    }
                }
                
            }
        }
    }
}

struct AddNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotificationView(vm: ViewModel())
    }
}
