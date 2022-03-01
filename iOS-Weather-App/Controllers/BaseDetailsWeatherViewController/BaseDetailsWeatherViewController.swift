//
// Created by pavels.garklavs on 23/02/2022.
//

import UIKit

class BaseDetailsWeatherViewController: UIViewController {

    private let tableView = UITableView()
    private let baseDetailsWeatherViewModel = BaseDetailsWeatherViewModel()

    private let networkManager = NetworkManager.shared

    private var longitude: Double?
    private var latitude: Double?

    func setupController() {
        setupTableView()
        setupNavigationBar()
    }

    func setNavTitle(title: String) {
        navigationItem.title = title
    }

    func setLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        tableView.reloadData()
    }
}

private extension BaseDetailsWeatherViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(DetailsDataCell.self, forCellReuseIdentifier: DetailsDataCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.separatorColor = .purple

        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .purple
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemPurple]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension BaseDetailsWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsDataCell.reuseIdentifier, for: indexPath) as? DetailsDataCell,
              let longitude = longitude,
              let latitude = latitude else {
            return .init()
        }

        networkManager.getWeather(longitude: longitude, latitude: latitude) { [weak self] Weather, error in
            guard let self = self, let weather = Weather?.daily[indexPath.row] else { return }

            cell.selectionStyle = .none

            cell.temperatureLabel.text = "\(String(format: "%.0f", weather.temp.day))°"
            cell.dateLabel.text = self.baseDetailsWeatherViewModel.convertToUsableDateString(dt: weather.dt)
            cell.windLabel.attributedText = self.baseDetailsWeatherViewModel.makeWindLabelText(windSpeed: weather.windSpeed)
            cell.maxTemperatureLabel.text = "\(String(format: "%.0f", weather.temp.max))°"
            cell.minTemperatureLabel.text = "\(String(format: "%.0f", weather.temp.min))°"
        }

        return cell
    }
}
