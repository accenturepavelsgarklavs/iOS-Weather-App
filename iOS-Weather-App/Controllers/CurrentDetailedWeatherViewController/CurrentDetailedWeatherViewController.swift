//
// Created by pavels.garklavs on 23/02/2022.
//

import UIKit

class CurrentDetailedWeatherViewController: UIViewController {

    private let tableView = UITableView()

    let currentDetailedWeatherModel = CurrentDetailedWeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }

}

private extension CurrentDetailedWeatherViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(CurrentDataCell.self, forCellReuseIdentifier: CurrentDataCell.reuseIdentifier)
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
        navigationItem.title = "Rīga"
    }
}

extension CurrentDetailedWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentDataCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

extension CurrentDetailedWeatherViewController: UITableViewDelegate {

}
