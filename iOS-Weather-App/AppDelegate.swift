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
        
        weatherModel.onTableButton = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeCurrentDetailsController(), animated: true)
        }
        
        weatherModel.onSearchTapped = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeSearchController(), animated: true)
        }
        
        weatherController.configure(weatherModel: weatherModel)
        
        return weatherController
    }
    
    func makeCurrentDetailsController() -> UIViewController {
        let currentDetailsController = CurrentLocDetailsViewController()
        let currentLocDetailsModel = CurrentLocDetailsViewModel()

        currentDetailsController.configure(currentLocDetailsViewModel: currentLocDetailsModel)

        return currentDetailsController
    }

    func makeSearchController() -> UIViewController {
        let searchController = SearchViewController()
        let searchViewModel = SearchViewModel()

        searchViewModel.onLocationTapped = { [weak self] name in
            guard let self = self, let name = name else { return }
            self.navigationController?.pushViewController(self.makeSearchedLocDetailsController(name: name), animated: true)
        }

        searchController.configure(searchViewModel: searchViewModel)

        return searchController
    }

    func makeSearchedLocDetailsController(name: String) -> SearchedDetailsViewController {
        let searchedLocDetailsController = SearchedDetailsViewController(name: name)
        let searchDetailsViewModel = SearchedDetailsViewModel()

        return searchedLocDetailsController
    }
}
