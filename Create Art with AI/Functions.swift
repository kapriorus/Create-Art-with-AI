//
//  Functions.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI
import Alamofire

func registerForNotification() {
    //For device token and push notifications.
    UIApplication.shared.registerForRemoteNotifications()
    
    let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
    //        center.delegate = self
    
    center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
        if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
        else {
            
        }
    })
}


