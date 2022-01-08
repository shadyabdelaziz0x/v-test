//
//  AppDelegate.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: SplashBuilder().build())
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        setupSDWebImageSettings()
        return true
    }
    
    private func setupSDWebImageSettings() {
        SDImageCache.shared.config.maxMemoryCost = AppConstants.shared.MAX_IMAGE_CACHE_SIZE
    }


}

