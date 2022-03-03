//
// Created by pavels.garklavs on 03/03/2022.
//

import UIKit

struct WindLabel {
    static func makeWindLabel(windSpeed: Double) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "wind")
        let fullString = NSMutableAttributedString(string: " ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: "\(String(windSpeed))m/s"))

        return fullString
    }
}
