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
            Section {
                Toggle(isOn: $vm.scheduleAtATime) {
                    Label("Date", systemImage: "calendar")
                }
                if vm.scheduleAtATime {
                    DatePicker("Schedule", selection: $vm.date)
                }
            }
            Section {
                Toggle(isOn: $vm.scheduleAtAnInterval) {
                    Label("Timer", systemImage: "timer")
                }
                if vm.scheduleAtAnInterval {
                    Picker("Interval", selection: $vm.timeInterval) {
                        ForEach(0...120, id: \.self) {
                            Text("\($0.description) min")
                        }
                    }
                }
            }
            Section {
                Toggle(isOn: $vm.scheduleAtALocation) {
                    Label("Location", systemImage: "location")
                }
                if vm.scheduleAtALocation {
                    Map(mapRect: $vm.mapArea, showsUserLocation: true)
                        .frame(height: 400)
                }
            }
            if vm.scheduleAtATime || vm.scheduleAtALocation || vm.scheduleAtAnInterval {
                Button("Schedule Notification") {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(alignment: .center)
            }
        }
        .onChange(of: vm.scheduleAtAnInterval) { _ in
            if vm.scheduleAtAnInterval {
                vm.scheduleAtATime = false
                vm.scheduleAtALocation = false
            }
        }
        .onChange(of: vm.scheduleAtATime) { _ in
            if vm.scheduleAtATime {
                vm.scheduleAtAnInterval = false
                vm.scheduleAtALocation = false
            }
        }
        .onChange(of: vm.scheduleAtALocation) { _ in
            if vm.scheduleAtALocation {
                vm.scheduleAtATime = false
                vm.scheduleAtAnInterval = false
                vm.requestLocation()
            }
        }
    }
}

struct AddNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotificationView(vm: ViewModel())
    }
}
