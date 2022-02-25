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
    private var navigationController: UINavigationController?
    private let weatherController = WeatherViewController()
    private let searchViewModel = SearchViewModel()
    private let currentDetailedWeatherModel = CurrentDetailedWeatherViewModel()
    private let searchController = SearchViewController()
    private let currentDetailsController = CurrentDetailedWeatherViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        weatherController.configure(searchViewModel: searchViewModel, currentDetailedWeatherModel: currentDetailedWeatherModel)

        navigationController = UINavigationController(rootViewController: weatherController)

        makeOpenSearchVC()
        makeOpenCurrentDetailsVC()
        
        window?.rootViewController = navigationController
        
        return true
    }
}

private extension AppDelegate {
    func makeOpenSearchVC() {
        searchViewModel.onSearchTapped = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.searchController, animated: true)
        }
    }

    func makeOpenCurrentDetailsVC() {
        currentDetailedWeatherModel.onTableButton = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.currentDetailsController, animated: true)
        }
    }
}
