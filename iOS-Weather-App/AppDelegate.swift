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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        navigationController = UINavigationController(rootViewController: makeWeatherController())
        
        window?.rootViewController = navigationController
        
        return true
    }
}

private extension AppDelegate {
    func makeWeatherController() -> UIViewController {
        let weatherController = WeatherViewController()
        let weatherModel = WeatherViewModel()
        
        weatherModel.onTableButton = { [weak self] longitude, latitude in
            guard let self = self, let longitude = longitude, let latitude = latitude else { return }
            self.navigationController?.pushViewController(self.makeCurrentDetailsController(longitude: longitude, latitude: latitude), animated: true)
        }
        
        weatherModel.onSearchTapped = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeSearchController(), animated: true)
        }
        
        weatherController.configure(weatherModel: weatherModel)
        
        return weatherController
    }
    
    func makeCurrentDetailsController(longitude: Double, latitude: Double) -> UIViewController {
        let currentDetailsController = CurrentLocDetailsViewController(longitude: longitude, latitude: latitude)
        let currentLocDetailsModel = CurrentLocDetailsViewModel()

        currentDetailsController.configure(currentLocDetailsViewModel: currentLocDetailsModel)

        return currentDetailsController
    }

    func makeSearchController() -> UIViewController {
        let searchController = SearchViewController()
        let searchViewModel = SearchViewModel()

        searchViewModel.onLocationTapped = { [weak self] longitude, latitude, name in
            guard let self = self, let longitude = longitude, let latitude = latitude, let name = name else { return }
            self.navigationController?.pushViewController(self.makeSearchedLocDetailsController(longitude: longitude, latitude: latitude, name: name), animated: true)
        }

        searchController.configure(searchViewModel: searchViewModel)

        return searchController
    }

    func makeSearchedLocDetailsController(longitude: Double, latitude: Double, name: String) -> SearchedDetailsViewController {
        let searchedLocDetailsController = SearchedDetailsViewController(longitude: longitude, latitude: latitude, name: name)
        let searchDetailsViewModel = SearchedDetailsViewModel()

        return searchedLocDetailsController
    }
}
