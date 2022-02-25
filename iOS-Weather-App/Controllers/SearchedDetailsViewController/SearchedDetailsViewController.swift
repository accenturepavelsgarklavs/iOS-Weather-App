//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation

final class SearchedDetailsViewController: BaseDetailsWeatherViewController {

    private var name: String?

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    required init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
    }

    override func viewDidLoad() {
        setupController()
        setNavTitle(title: name ?? "")
    }

}
