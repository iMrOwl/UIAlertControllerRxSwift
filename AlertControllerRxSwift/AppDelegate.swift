//
//  AppDelegate.swift
//  AlertControllerRxSwift
//
//  Created by Сычев Евгений Дмитриевич on 28.07.2020.
//  Copyright © 2020 Сычев Евгений Дмитриевич. All rights reserved.
//

import UIKit

// MARK: - AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public properties

    var window: UIWindow?
    
    // MARK: - Public methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = CheckInViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        return true
    }
    
}
