//
//  AppDelegate.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let weatherController = WeatherViewController()
        let navigationController = UINavigationController(rootViewController: weatherController)
        onOpenSearchController(controller: weatherController, navController: navigationController)
        onOpenCurrentDetailsViewController(controller: weatherController, navController: navigationController)
        
        window?.rootViewController = navigationController
        
        return true
    }
}

private extension AppDelegate {
    func onOpenSearchController(controller: WeatherViewController, navController: UINavigationController) {
        let searchController = SearchViewController()
        controller.weatherModel.onSearchTapped = { [weak self] in
            guard self == self else { return }
            navController.pushViewController(searchController, animated: true)
        }
    }

    func onOpenCurrentDetailsViewController(controller: WeatherViewController, navController: UINavigationController) {
        let currentDetailsViewController = CurrentDetailedWeatherViewController()
        controller.weatherModel.onTableButton = { [weak self] in
            guard self == self else { return }
            navController.pushViewController(currentDetailsViewController, animated: true)
        }
    }
}
