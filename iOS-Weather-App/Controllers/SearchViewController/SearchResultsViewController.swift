//
// Created by pavels.garklavs on 24/02/2022.
//

import UIKit

class SearchResultsViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        setupTableView()
    }
}

private extension SearchResultsViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorColor = .purple

        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "Test"

        return cell
    }
}
