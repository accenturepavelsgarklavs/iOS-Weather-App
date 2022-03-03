//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class SearchedDetailsViewModel {
    var location: CLLocation?
    var name: String?

    required init(location: CLLocation?, name: String?) {
        self.location = location
        self.name = name
    }
}
