//
//  ViewID.swift
//  KMMIC
//
//  Created by MarkG on 12/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

enum ViewID {

    case splash(Splash)

    enum Splash: String {
        case background = "splash.background"
        case logo = "splash.logo"
    }

    func callAsFunction() -> String {
        switch self {
        case let .splash(splash):
            return splash.rawValue
        }
    }
}
