//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation

final class SearchedDetailsViewController: BaseDetailsWeatherViewController {

    private var longitude: Double?
    private var latitude: Double?
    private var name: String?

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    required init(longitude: Double, latitude: Double, name: String) {
        super.init(nibName: nil, bundle: nil)
        self.longitude = longitude
        self.latitude = latitude
        self.name = name
    }

    override func viewDidLoad() {
        setLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        setupController()
        setNavTitle(title: name ?? "")
    }

}
