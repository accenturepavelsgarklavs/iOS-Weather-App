//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation

final class CurrentLocDetailsViewController: BaseDetailsWeatherViewController {

    private var currentLocDetailsViewModel: CurrentLocDetailsViewModel?

    override func viewDidLoad() {
        setupController()
        setNavTitle(title: "Rīga")
    }

    func configure(currentLocDetailsViewModel: CurrentLocDetailsViewModel) {
        self.currentLocDetailsViewModel = currentLocDetailsViewModel
    }

}
