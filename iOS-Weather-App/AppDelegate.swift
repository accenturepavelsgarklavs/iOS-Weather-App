//
//  AppDelegate.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit
import CoreLocation

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
        let weatherViewModel = WeatherViewModel()

        pushCurrentDetailsController(viewModel: weatherViewModel)
        pushSearchController(viewModel: weatherViewModel)

        weatherController.configure(weatherModel: weatherViewModel)
        
        return weatherController
    }
    
    func makeCurrentDetailsController(location: CLLocation) -> UIViewController {
        let currentDetailsController = CurrentLocDetailsViewController()
        let currentLocDetailsModel = CurrentLocDetailsViewModel(location: location)

        currentDetailsController.configure(currentLocDetailsViewModel: currentLocDetailsModel)

        return currentDetailsController
    }

    func makeSearchController() -> UIViewController {
        let searchController = SearchViewController()
        let searchViewModel = SearchViewModel()

        searchViewModel.onLocationTapped = { [weak self] location, name in
            guard let self = self, let location = location, let name = name else { return }
            self.navigationController?.pushViewController(self.makeSearchedLocDetailsController(location: location, name: name), animated: true)
        }

        searchController.configure(searchViewModel: searchViewModel)

        return searchController
    }

    func makeSearchedLocDetailsController(location: CLLocation, name: String) -> SearchedDetailsViewController {
        let searchedLocDetailsController = SearchedDetailsViewController()
        let searchDetailsViewModel = SearchedDetailsViewModel(location: location, name: name)

        searchedLocDetailsController.configure(searchDetailsViewModel: searchDetailsViewModel)

        return searchedLocDetailsController
    }

    func pushCurrentDetailsController(viewModel: WeatherViewModel) {
        viewModel.onTableButton = { [weak self] location in
            guard let self = self, let location = location else { return }
            self.navigationController?.pushViewController(self.makeCurrentDetailsController(location: location), animated: true)
        }
    }

    func pushSearchController(viewModel: WeatherViewModel) {
        viewModel.onSearchTapped = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeSearchController(), animated: true)
        }
    }
}
