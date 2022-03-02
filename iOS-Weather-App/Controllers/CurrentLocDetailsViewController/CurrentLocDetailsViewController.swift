//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class CurrentLocDetailsViewController: BaseDetailsWeatherViewController {

    private var currentLocDetailsViewModel: CurrentLocDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation(location: (currentLocDetailsViewModel?.location))
    }

    func configure(currentLocDetailsViewModel: CurrentLocDetailsViewModel) {
        self.currentLocDetailsViewModel = currentLocDetailsViewModel
    }
}


