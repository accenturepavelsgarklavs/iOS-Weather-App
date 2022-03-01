//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class CurrentLocDetailsViewController: BaseDetailsWeatherViewController {

    private var currentLocDetailsViewModel: CurrentLocDetailsViewModel?

    private var longitude: Double?
    private var latitude: Double?

    override func viewDidLoad() {
        setLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        setupController()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    required init(longitude: Double, latitude: Double) {
        super.init(nibName: nil, bundle: nil)
        self.longitude = longitude
        self.latitude = latitude
    }

    func configure(currentLocDetailsViewModel: CurrentLocDetailsViewModel) {
        self.currentLocDetailsViewModel = currentLocDetailsViewModel
    }
}


