//
//  NotificationManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import UIKit
import Observation
import UserNotifications
import iOS_Backend_SDK

@Observable final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    var notificationsAllowed: Bool = false
    var deviceToken: String = "Simulator \(UUID().uuidString)"
    
    private var requestedOnce: Bool = false
    
    func requestAuthorization(openSettings: Bool = false) async {
        do {
            self.notificationsAllowed = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            
            if self.requestedOnce && openSettings {
                DispatchQueue.main.async {
                    UIApplication.shared.open(URL(string: UIApplication.openNotificationSettingsURLString)!)
                }
            }
            
            self.requestedOnce = true
            
        } catch {
            print("Error requesting notifications authorization: \(error)")
            return
        }
    }
    
    func setDeviceToken(_ tokenData: Data) {
        let hexadecimalBytes = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
        deviceToken = hexadecimalBytes
        DispatchQueue.main.async {
            Backend.shared.config?.deviceToken = self.deviceToken
        }
        
        print("DEVICE TOKEN: \(hexadecimalBytes)")
    }
    
}
