//
//  ThankScreenSpec.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 18/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared

@testable import KMMIC

final class ThankScreenSpec: QuickSpec {

    override func spec() {

        describe("a Thank screen") {

            var navigator: NavigatorMock!
            var didSetScreen = false

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true
                navigator = .init()
                self.app().setScreen(
                    screen: .thank,
                    navigator: navigator
                )
                self.tester().waitForAnimationsToFinish()
            }

            it("has title text") {
                self.tester().waitForView(withViewID: .thank(.titleText))
            }

            it("has success animation") {
                self.tester().waitForView(withViewID: .thank(.successAnimation))
            }

            it("triggers navigator call steps") {
                expect(navigator.stepsRoutesCalled)
                    .toEventually(beTrue(), timeout: .seconds(10))
            }
        }
    }
}
