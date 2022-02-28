//
// Created by pavels.garklavs on 28/02/2022.
//

import UIKit

class BaseDetailsWeatherViewModel {
    func convertToUsableDateString(dt: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "EEEE, MMM d"
        let dateString = dateformatter.string(from: date)

        return dateString
    }

    func makeWindLabelText(windSpeed: Double) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "wind")
        let fullString = NSMutableAttributedString(string: " ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: "\(String(windSpeed))m/s"))

        return fullString
    }
}
