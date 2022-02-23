//
// Created by pavels.garklavs on 23/02/2022.
//

import UIKit

class CurrentDetailedWeatherViewController: UIViewController {

    private let detailsTableView = UITableView()

    override func viewDidLoad() {
        setupTableView()
    }
}

private extension CurrentDetailedWeatherViewController {
    func setupTableView() {
        view.addSubview(detailsTableView)
        detailsTableView.delegate = self

        detailsTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}

//extension CurrentDetailedWeatherViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}

extension CurrentDetailedWeatherViewController: UITableViewDelegate {

}
