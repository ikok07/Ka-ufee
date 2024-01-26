//
//  SettingsNotificationsView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var notificationsAllowed: Bool = false
    
    var body: some View {
        List {
            Section("") {
                ListRowView(label: "Notifications allowed") {
                    if notificationsAllowed {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.accentColor)
                    } else {
                        Button("Enable") {
                            Task {
                                await NotificationManager.shared.requestAuthorization(openSettings: true)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationTitle("Notifications")
        .onAppear {
            Task {
                await toggleNotifications()
            }
        }
        .onChange(of: self.scenePhase) { oldValue, newValue in
            if newValue == .active {
                Task {
                    await toggleNotifications()
                }
            }
        }
        .animation(.default, value: self.notificationsAllowed)
    }
    
    func toggleNotifications() async {
        await NotificationManager.shared.requestAuthorization()
        self.notificationsAllowed = NotificationManager.shared.notificationsAllowed
    }
    
}
