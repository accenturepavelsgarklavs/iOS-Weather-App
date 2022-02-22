//
//  ViewController.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

final class WeatherViewController: UIViewController{

    private let locationManager = CLLocationManager()

    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let skyConditionLabel = UILabel()
    private let detailsStackView = UIStackView()
    private let network = WeatherNetwork()
    let weatherModel = WeatherViewControllerModel()

    private var currentLocationName: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentLocation{ (success) -> Void in
            if success {
                guard let currentLocationName = currentLocationName else { return }
                setupNetwork(input: currentLocationName)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupCityNameLabel()
        setupTemperatureLabel()
        setupSkyConditionLabel()
        setupDetailsStackView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupBackground()
    }

}

private extension WeatherViewController {
    func setupNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Current Location"
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc func searchTapped() {
        weatherModel.onSearchTapped?()
    }

    func setupBackground() {
        UIGraphicsBeginImageContext(view.frame.size)
        if traitCollection.userInterfaceStyle == .dark {
            UIImage(named: "dayBackground")?.draw(in: view.bounds)
        }
        else {
            UIImage(named: "nightBackground")?.draw(in: view.bounds)
        }
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }

    func setupCityNameLabel() {
        view.addSubview(cityNameLabel)
        cityNameLabel.font = UIFont(name: "Roboto", size: 28)
        cityNameLabel.textColor = .white

        cityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(view).offset(120)
        }
    }

    func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)
        temperatureLabel.font = UIFont(name: "Roboto", size: 128)
        temperatureLabel.textColor = .white

        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(cityNameLabel.snp.bottom)
        }
    }

    func setupSkyConditionLabel() {
        view.addSubview(skyConditionLabel)
        skyConditionLabel.font = UIFont(name: "BebasNeue", size: 24)
        skyConditionLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        skyConditionLabel.textColor = .white

        skyConditionLabel.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
        }
    }

    func setupDetailsStackView() {
        view.addSubview(detailsStackView)
        detailsStackView.backgroundColor = UIColor(red: 240.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .fillEqually
        detailsStackView.layer.cornerRadius = 15

        detailsStackView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    func setupNetwork(input: String) {
        network.getWeather(input: input) { [weak self] Weather, error in
            guard let self = self else { return }
            let currTemp = String(format: "%.0f", self.weatherModel.celsius(Weather?.main.temp) as CVarArg)

            self.cityNameLabel.text = Weather?.name
            self.temperatureLabel.text = "\(currTemp)°C"
            self.skyConditionLabel.text = Weather?.weather[0].main
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func getCurrentLocation(finished: (_ success: Bool) -> Void) {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        finished(true)
    }
    func fetchCityAndCountry(from location: CLLocation ,completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                    placemarks?.first?.country,
                    error)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { [self] city, country, error in
            guard let city = city, error == nil else { return }
            currentLocationName = city
        }
    }
}