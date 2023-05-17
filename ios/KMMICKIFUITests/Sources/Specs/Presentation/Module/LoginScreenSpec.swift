//
//  LoginScreenSpec.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 15/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick

@testable import KMMIC

final class LoginScreenSpec: QuickSpec {

    override func spec() {

        describe("a LoginScreen screen") {

            var navigator: NavigatorMock!
            var viewModel: LoginViewModelMock!
            var didSetScreen = false

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true
                navigator = .init()
                viewModel = .init()

                Container.shared.loginViewModel.register {
                    viewModel
                }
                self.app().setScreen(screen: .login, navigator: navigator)
                self.tester().waitForAnimationsToFinish(withTimeout: 5.0, stabilizationTime: 10.0)
            }

            it("has email field") {
                self.tester().waitForView(withViewID: .login(.emailField))
            }

            it("has password field") {
                self.tester().waitForView(withViewID: .login(.passwordField))
            }

            it("has login button") {
                self.tester().waitForView(withViewID: .login(.loginButton))
            }

            describe("its login button tap") {

                beforeEach {
                    viewModel.underlyingIsAllValidated = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                    self.tester().tapView(withViewID: .login(.loginButton))
                }

                it("triggers viewModel to call login()") {
                    expect(viewModel.loginCalled) == true
                }
            }

            context("when viewModel.didLogin is true") {

                beforeEach {
                    viewModel.underlyingDidLogin = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("triggers navigator to show the Home screen") {
                    expect(navigator.showScreenByReceivedArguments?.screen)
                        .toEventually(equal(.home))
                }
            }

            context("when viewModel.isLoading is true") {

                beforeEach {
                    viewModel.underlyingIsLoading = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("shows Progress HUD") {
                    self.tester().waitForView(withViewID: .general(.progressHUD))
                }
            }
        }
    }
}
