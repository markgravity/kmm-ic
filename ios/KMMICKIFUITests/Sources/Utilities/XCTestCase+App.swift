//
//  XCTestCase+App.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 15/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import XCTest

@testable import KMMIC

class App {

    func setScreen(screen: Navigator.Screen, navigator: Navigator? = nil) {
        let originNavigator = Container.shared.navigator()
        if let navigator = navigator {
            Container.shared.navigator.register {
                navigator
            }
        }

        originNavigator.pop()
        originNavigator.show(screen: screen, by: .root)
    }
}

extension XCTestCase {

    func app() -> App { .init() }
}
