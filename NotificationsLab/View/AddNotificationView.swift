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
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm: ViewModel
    
    @State var scheduleNotificationFail = false
    @State var scheduleNotificationFailDescription = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Notification Type", selection: $vm.notificatonSelected) {
                        ForEach(ViewModel.NotificationSelection.allCases) {
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
                    TextField("Title", text: $vm.title)
                    TextField("Content", text: $vm.body)
                }
                Section {
                    Button("Schedule Notification") {
                        Task {
                            
                            // Handle the errors by catching them and setting "scheduleNotificationFail" to true
                            do {
                                try await vm.scheduleNotification()
                            } catch(let error) {
                                scheduleNotificationFail = true
                                scheduleNotificationFailDescription = error.localizedDescription
                                print(scheduleNotificationFailDescription)
                            }
                        }
                        dismiss()
                    }
                    .disabled(vm.title.isEmpty || vm.body.isEmpty)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Create a Notification")
            .navigationBarTitleDisplayMode(.inline)
            
            // Display the error description in an alert
            .alert(scheduleNotificationFailDescription, isPresented: $scheduleNotificationFail) {
                Button("ok") {
                    scheduleNotificationFail = false
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
