//
//  ContentView.swift
//  NotificationsLab
//
//  Created by Cory Tripathy on 5/22/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: ViewModel
    @State var activityToAdd = ""
    @State var isAddingNotification = false
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.notifications.isEmpty {
                    Text("Schedule a Notification!")
                } else {
                    List {
                        ForEach(0..<vm.notifications.count, id: \.self) { index in
                            let notification = vm.notifications[index]
                            VStack(alignment: .leading) {
                                Text(notification.title)
                                Text(notification.body)
                                    .font(.caption)
                                Text(notification.description)
                                    .font(.caption2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onDelete { index in
                            let notification = vm.notifications[index.first!]
                            vm.cancelNotification(notification)
                        }
                    }
                }
            }
            .navigationTitle("Notification Lab")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingNotification = true
                    } label: {
                        Label("Add a notification", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNotification) {
                AddNotificationView(vm: vm)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ViewModel())
    }
}
