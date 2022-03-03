//
// Created by pavels.garklavs on 02/03/2022.
//

import Foundation

extension TimeInterval {
     func convertToUsableDateString() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "EEEE, MMM d"
        let dateString = dateformatter.string(from: date)

        return dateString
    }
}
