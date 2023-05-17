//
//  SplashSpec.swift
//  KMMIC
//
//  Created by MarkG on 12/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Nimble
import Quick

@testable import KMMIC

final class SplashSpec: QuickSpec {

    override func spec() {

        describe("a Splash screen") {

            var navigator: NavigatorMock!
            var didSetScreen = false

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true

                navigator = .init()
                self.app().setScreen(screen: .splash, navigator: navigator)
                self.tester().waitForAnimationsToFinish()
            }

            it("has background image") {
                self.tester().waitForView(withViewID: .splash(.background))
            }

            it("has logo image") {
                self.tester().waitForView(withViewID: .splash(.logo))
            }

            it("triggers navigator to show the Login screen") {
                expect(navigator.showScreenByReceivedArguments?.screen)
                    .toEventually(equal(.login), timeout: .seconds(2))
            }
        }
    }
}
