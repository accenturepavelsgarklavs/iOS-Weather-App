//
// Created by pavels.garklavs on 28/02/2022.
//

import UIKit
import CoreLocation

class BaseDetailsWeatherViewModel {
    func makeWindLabelText(windSpeed: Double) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "wind")
        let fullString = NSMutableAttributedString(string: " ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: "\(String(windSpeed))m/s"))

        return fullString
    }
}
