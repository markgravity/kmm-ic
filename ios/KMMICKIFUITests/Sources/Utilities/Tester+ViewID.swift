//  swiftlint:disable:this file_name
//
//  Tester+ViewID.swift
//  KMMIC
//
//  Created by MarkG on 12/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import KIF

extension KIFUITestActor {

    func waitForView(withViewID viewID: ViewID) {
        waitForView(withAccessibilityIdentifier: viewID())
    }

    func waitForTappableView(withViewID viewID: ViewID) {
        waitForTappableView(withAccessibilityIdentifier: viewID())
    }

    func enterText(_ text: String, intoViewWithViewID viewID: ViewID) {
        enterText(text, intoViewWithAccessibilityIdentifier: viewID())
    }

    func tapView(withViewID viewID: ViewID) {
        tapView(withAccessibilityIdentifier: viewID())
    }
}
