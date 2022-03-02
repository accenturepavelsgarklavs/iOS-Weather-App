//
// Created by pavels.garklavs on 23/02/2022.
//

import UIKit
import CoreLocation

class BaseDetailsWeatherViewController: UIViewController {

    private let tableView = UITableView()
    private let baseDetailsWeatherViewModel = BaseDetailsWeatherViewModel()

    private var location: CLLocation?

    override func viewDidLoad() {
        setupController()
    }

    func setupController() {
        setupTableView()
        setupNavigationBar()
    }

    func setNavTitle(title: String?) {
        navigationItem.title = title
    }

    func setLocation(location: CLLocation?) {
        self.location = location
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
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension BaseDetailsWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsDataCell.reuseIdentifier, for: indexPath) as? DetailsDataCell,
              let location = location else {
            return .init()
        }

        NetworkManager.getWeather(location: location) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if case .success(let weather) = result {
                    let weather = weather.daily[indexPath.row]
                    cell.selectionStyle = .none
                    cell.temperatureLabel.text = "\(String(format: "%.0f", weather.temp.day))°"
                    cell.dateLabel.text = weather.dt.convertToUsableDateString()
                    cell.windLabel.attributedText = self.baseDetailsWeatherViewModel.makeWindLabelText(windSpeed: weather.windSpeed)
                    cell.maxTemperatureLabel.text = "\(String(format: "%.0f", weather.temp.max))°"
                    cell.minTemperatureLabel.text = "\(String(format: "%.0f", weather.temp.min))°"
                } else if case .failure(let error) = result {
                    AlertPopUp.makePopUp(controller: self, error: error)
                }
            }
        }
        return cell
    }
}
