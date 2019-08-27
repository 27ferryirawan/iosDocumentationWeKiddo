//
//  ACNotificationCenter.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 10/01/19.
//  Copyright © 2019 PT. Absolute Connection.. All rights reserved.
//

import Foundation
import UserNotificationsUI
import UserNotifications
import FirebaseMessaging

class ACNotificationCenter: NSObject, UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        let userInfo = response.notification.request.content.userInfo/* as! [String:Any]*/
        print(userInfo)
        /*
         Open Action
         [AnyHashable("google.c.a.e"): 1, AnyHashable("gcm.message_id"): 0:1547138854730558%ed0af5d7ed0af5d7, AnyHashable("aps"): {
         alert =     {
         body = "Admin telah didapatkan untuk no.order: T-20190110-1";
         title = "Micasa - Order T-20190110-1";
         };
         sound = mySound;
         }]
         */
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
            UserDefaults.standard.set(true, forKey: "isFromNotif")
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: userInfo)
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        print("ini dari notif center: \(userInfo)")
//        appDelegate.goToHomePage()
//        let vc = OrderPagerViewController()
//        appDelegate.window?.rootViewController?.tabBarController?.selectedViewController = vc
//        completionHandler()
    }
}

extension ACNotificationCenter: MessagingDelegate {
    // [START refresh_token]
    /*
     func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
     let dataDict:[String: String] = ["token": fcmToken]
     print(dataDict.values)
     NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
     TODO: If necessary send token to application server.
     Note: This callback is fired at each app startup and whenever a new token is generated.
     DispatchQueue.global().async {
     self.sendUpdateFCMToken(token: fcmToken)
     }
     
     }
     */
    @available(iOS 10.0, *)
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "tokenFCM")
        UserDefaults.standard.synchronize()
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    @available(iOS 10.0, *)
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    }
    // [END ios_10_data_message]
}

