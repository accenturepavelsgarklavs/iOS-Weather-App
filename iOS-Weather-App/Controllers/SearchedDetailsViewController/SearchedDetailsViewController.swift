//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class SearchedDetailsViewController: BaseDetailsWeatherViewController {

    private var viewModel: SearchedDetailsViewModel?

    override func viewDidLoad() {
        setLocation(location: viewModel?.location)
        setupController()
        setNavTitle(title: viewModel?.name)
    }

    func configure(searchDetailsViewModel: SearchedDetailsViewModel) {
        viewModel = searchDetailsViewModel
    }

}
