//
// Created by pavels.garklavs on 22/02/2022.
//

import Foundation
import CoreLocation

final class SearchViewModel {
    var onLocationTapped: ((CLLocation?, String?) -> Void)?
}
