//
//  DateHelper.swift
//  KMMIC
//
//  Created by MarkG on 24/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol DateHelperProtocol {

    var today: Date { get }
}

final class DateHelper: DateHelperProtocol {

    var today: Date { .init() }
}
