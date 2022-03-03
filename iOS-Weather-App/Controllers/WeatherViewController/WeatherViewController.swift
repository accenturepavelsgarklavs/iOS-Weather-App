//
//  ViewController.swift
//  iOS-Weather-App
//
//  Created by pavels.garklavs on 22/02/2022.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController{

    private let locationNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let skyConditionLabel = UILabel()
    private let tableButton = UIButton()
    private let detailsStackView = UIStackView()
    private let detailStackWindTitleLabel = UILabel()
    private let detailStackWindValueLabel = UILabel()
    private let detailStackHumidityTitleLabel = UILabel()
    private let detailStackHumidityValueLabel = UILabel()
    private let detailStackVisibilityTitleLabel = UILabel()
    private let detailStackVisibilityValueLabel = UILabel()
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

    private var location: CLLocation?

    private let locationManager = CLLocationManager()
    private var weatherViewModel: WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupBackground()
        setupNavigationBar()
        setupCityNameLabel()
        setupTemperatureLabel()
        setupDetailsStackView()
        setupSkyConditionLabel()
        setupTableButton()
    }

    func configure(weatherModel: WeatherViewModel) {
        self.weatherViewModel = weatherModel
    }

}

private extension WeatherViewController {
    func setupNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Weather"
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc func searchTapped() {
        weatherViewModel?.onSearchTapped?()
    }

    func setupBackground() {
        if traitCollection.userInterfaceStyle == .light {
            backgroundImage.image = UIImage(named: "dayBackground")
        }
        else {
            backgroundImage.image = UIImage(named: "nightBackground")
        }
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    func setupCityNameLabel() {
        view.addSubview(locationNameLabel)
        locationNameLabel.font = UIFont(name: "Roboto", size: 28)
        locationNameLabel.textColor = .white

        locationNameLabel.snp.makeConstraints { make in
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
            make.top.equalTo(locationNameLabel.snp.bottom)
        }
    }

    func setupSkyConditionLabel() {
        view.addSubview(skyConditionLabel)
        skyConditionLabel.font = UIFont(name: "BebasNeue", size: 24)
        skyConditionLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        skyConditionLabel.textColor = .white

        skyConditionLabel.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.top.equalTo(view.snp.centerY).offset(60)
        }
    }

    func setupDetailsStackView() {
        view.addSubview(detailsStackView)
        detailsStackView.backgroundColor = UIColor(red: 200.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3)
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .equalCentering
        detailsStackView.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 15, right: 30)
        detailsStackView.isLayoutMarginsRelativeArrangement = true
        detailsStackView.layer.cornerRadius = 20
        detailsStackView.layer.borderWidth = 2
        detailsStackView.layer.borderColor = UIColor.white.cgColor

        detailsStackView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        setupDetailStackWindLabel()
        setupDetailStackHumidityLabel()
        setupDetailStackMaxTempLabel()
    }

    func setupDetailStackWindLabel() {
        let windStack = UIStackView()
        detailsStackView.addArrangedSubview(windStack)
        windStack.addArrangedSubview(detailStackWindValueLabel)
        windStack.addArrangedSubview(detailStackWindTitleLabel)
        windStack.axis = .vertical
        windStack.distribution = .fillEqually
        windStack.alignment = .center

        detailStackWindValueLabel.textColor = .white
        detailStackWindTitleLabel.textColor = .white
        detailStackWindValueLabel.font = UIFont(name: "BebasNeue", size: 26)

        detailStackWindTitleLabel.text = "Wind"
    }

    func setupDetailStackHumidityLabel() {
        let humidityStack = UIStackView()
        detailsStackView.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(detailStackHumidityValueLabel)
        humidityStack.addArrangedSubview(detailStackHumidityTitleLabel)
        humidityStack.axis = .vertical
        humidityStack.distribution = .fillEqually
        humidityStack.alignment = .center

        detailStackHumidityValueLabel.textColor = .white
        detailStackHumidityTitleLabel.textColor = .white
        detailStackHumidityValueLabel.font = UIFont(name: "BebasNeue", size: 26)

        detailStackHumidityTitleLabel.text = "Humidity"
    }

    func setupDetailStackMaxTempLabel() {
        let visibilityStack = UIStackView()
        detailsStackView.addArrangedSubview(visibilityStack)
        visibilityStack.addArrangedSubview(detailStackVisibilityValueLabel)
        visibilityStack.addArrangedSubview(detailStackVisibilityTitleLabel)
        visibilityStack.axis = .vertical
        visibilityStack.distribution = .fillEqually
        visibilityStack.alignment = .center

        detailStackVisibilityValueLabel.textColor = .white
        detailStackVisibilityTitleLabel.textColor = .white
        detailStackVisibilityValueLabel.font = UIFont(name: "BebasNeue", size: 26)

        detailStackVisibilityTitleLabel.text = "Visibility"
    }


    func setupTableButton() {
        view.addSubview(tableButton)
        tableButton.setTitle("Table", for: .normal)
        tableButton.backgroundColor = .white
        tableButton.setTitleColor(.black, for: .normal)
        tableButton.setTitleColor(.gray, for: .highlighted)
        tableButton.layer.cornerRadius = 10
        tableButton.titleLabel?.font = UIFont(name: "BebasNeue", size: 18)

        tableButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.width.equalTo(160)
        }

        tableButton.addTarget(self, action: #selector(didTapTableButton), for: .touchUpInside)
    }

    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    @objc func didTapTableButton() {
        weatherViewModel?.onTableButton?(location)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }

        weatherViewModel?.getWeather(location: location, completion: { [weak self] result in
            if case .success(let weather) = result {
                let weather = weather.current

                let weatherVisibility = Double(weather.visibility) / 1000

                self?.temperatureLabel.text = "\(String(format: "%.0f", weather.temp))°"
                self?.skyConditionLabel.text = weather.weather[0].weatherDescription
                self?.detailStackVisibilityValueLabel.text = "\(String(format: "%.1f", weatherVisibility))km"
                self?.detailStackHumidityValueLabel.text = "\(String(weather.humidity))%"
                self?.detailStackWindValueLabel.text = "\(String(weather.windSpeed))m/s"

                location.fetchCityAndCountry { city, country, error in
                    guard let city = city, let _ = country, let error = error else { return }
                    self?.locationNameLabel.text = city
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            } else if case .failure(let error) = result {
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        })

    }
}
