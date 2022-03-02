//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class SearchedDetailsViewController: BaseDetailsWeatherViewController {

    private var searchDetailsViewModel: SearchedDetailsViewModel?

    override func viewDidLoad() {
        setLocation(location: searchDetailsViewModel?.location)
        setupController()
        setNavTitle(title: searchDetailsViewModel?.name)
    }

    func configure(searchDetailsViewModel: SearchedDetailsViewModel) {
        self.searchDetailsViewModel = searchDetailsViewModel
    }

}
