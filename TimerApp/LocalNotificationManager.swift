//
//  LocalNotificationManager.swift
//  TimerApp
//
//  Created by Josh Kraskin on 1/14/21.
//

import Foundation
import UserNotifications

struct LocalNotificationManager {
    
    static func autherizeLocalNotifications () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge,])
            {(granted, error) in
            if granted {
                print("Notification Authorization Granted!")
            }
    
        }
        
    
    }
    //Notification set up
//        func notification(dateComponents: DateComponents, timerID: String){
//    
//    
//            let center = UNUserNotificationCenter.current()
//    
//            let content = UNMutableNotificationContent()
//            content.title = "\(timerID) Complete"
//            content.body = "\(timerID) is complete!"
//            content.sound = .default
//    
//    
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//    
//    
//            let request = UNNotificationRequest(identifier: timerID, content: content, trigger: trigger)
//    
//                center.add(request) { (error) in
//                    }
//    
//    
//        }
//            //Reset timer when user responds to notification
//        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//            completionHandler([ .sound, .banner, .badge])
//            }
//            func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                        didReceive response: UNNotificationResponse,
//                                        withCompletionHandler completionHandler: @escaping () -> Void) {
//                if response.notification.request.identifier == Timer1.timerID {
//                    resetTimer1(self)}
//                if response.notification.request.identifier == Timer2.timerID {
//                    resetTimer2(self)
//                    }
//                if response.notification.request.identifier == Timer3.timerID {
//                    resetTimer3(self)
//                    }
//                if response.notification.request.identifier == Timer4.timerID {
//                    resetTimer4(self)
//                    }
//    
//                completionHandler()
//    
//            }
//        
}
