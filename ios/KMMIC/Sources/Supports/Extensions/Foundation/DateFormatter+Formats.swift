//
//  DateFormatter+Formats.swift
//  KMMIC
//
//  Created by MarkG on 24/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let wideNameDayMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        return dateFormatter
    }()
}
