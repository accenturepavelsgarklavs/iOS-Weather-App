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
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let weatherController = WeatherViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        navigationController = UINavigationController(rootViewController: weatherController)

        makeOpenSearchVC(controller: weatherController)
        makeOpenCurrentDetailsVC(controller: weatherController)
        
        window?.rootViewController = navigationController
        
        return true
    }
}

private extension AppDelegate {
    func makeOpenSearchVC(controller: WeatherViewController) {
        let searchController = controller.searchController
        searchController.searchViewModel.onSearchTapped = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(searchController, animated: true)
        }
    }

    func makeOpenCurrentDetailsVC(controller: WeatherViewController) {
        let currentDetailsController = controller.currentDetailsController
        currentDetailsController.currentDetailedWeatherModel.onTableButton = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(currentDetailsController, animated: true)
        }
    }
}
