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
                if vm.activities.isEmpty {
                    Text("Schedule a Notification!")
                } else {
                    List(vm.activities) { activity in
                        VStack {
                            Text(activity.name)
                            Text(activity.dateScheduled.description(with: .autoupdatingCurrent))
                                .font(.caption)
                                .foregroundColor(.secondary)
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
