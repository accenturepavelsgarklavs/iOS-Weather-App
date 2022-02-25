//
// Created by pavels.garklavs on 23/02/2022.
//

import UIKit

class BaseDetailsWeatherViewController: UIViewController {

    private let tableView = UITableView()

    func setupController() {
        setupTableView()
        setupNavigationBar()
    }

    func setNavTitle(title: String) {
        navigationItem.title = title
    }
}

private extension BaseDetailsWeatherViewController {
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
    }
}

extension BaseDetailsWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentDataCell.reuseIdentifier, for: indexPath)
        return cell
    }
}
