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
                    List(vm.notifications) { notification in
                        VStack {
                            Text(notification.description)
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
