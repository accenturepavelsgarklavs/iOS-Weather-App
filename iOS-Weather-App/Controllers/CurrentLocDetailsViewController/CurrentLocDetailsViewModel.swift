//
// Created by pavels.garklavs on 25/02/2022.
//

import Foundation
import CoreLocation

final class CurrentLocDetailsViewModel {
    var location: CLLocation?

    init(location: CLLocation) {
        self.location = location
    }
}
