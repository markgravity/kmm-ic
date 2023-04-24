//
//  AlertDescription.swift
//  KMMIC
//
//  Created by MarkG on 24/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct AlertDescription: Identifiable, Equatable {

    let title: String
    let message: String

    var id: String {
        "\(title) \(message)"
    }
}
