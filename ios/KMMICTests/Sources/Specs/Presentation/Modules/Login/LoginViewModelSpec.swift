//
//  LoginViewModelSpec.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared
import TestableCombinePublishers

@testable import KMMIC

final class LoginViewModelSpec: QuickSpec {

    override func spec() {

        var loginUseCaseMock: LoginUseCaseMock!
        var viewModel: LoginViewModel!

        describe("a LoginViewModel") {

            beforeEach {
                loginUseCaseMock = .init()
                Container.shared.loginUseCase.register { loginUseCaseMock }
                viewModel = LoginViewModel()
            }

            describe("its isAllValidated") {

                context("when password or email is emptied") {

                    beforeEach {
                        viewModel.email = "dev@nimblehq.co"
                        viewModel.password = ""
                    }

                    it("sets isAllValidated to true") {
                        expect(viewModel.isAllValidated) == false
                    }
                }

                context("when both password and email aren't emptied") {

                    beforeEach {
                        viewModel.email = "dev@nimblehq.co"
                        viewModel.password = "12345678"
                    }

                    it("sets isAllValidated to true") {
                        expect(viewModel.isAllValidated) == true
                    }
                }
            }

            describe("its login call") {

                beforeEach {
                    viewModel.email = "dev@nimblehq.co"
                    viewModel.password = "12345678"
                }

                context("when logInUseCase emits success") {

                    beforeEach {
                        loginUseCaseMock.callAsNativeEmailPasswordReturnValue = { success, _ in
                            _ = success(.dummy, .shared)
                            return { .shared }
                        }
                        viewModel.login()
                    }

                    it("sets isLoading correctly") {
                        viewModel.$isLoading
                            .collect(2)
                            .expect([true, false])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets didLogin to true") {
                        expect(viewModel.didLogin).toEventually(beTrue())
                    }

                    it("triggers logInUseCase to call") {
                        expect(loginUseCaseMock.callAsNativeEmailPasswordCalled) == true
                    }
                }

                context("when logInUseCase emits failure") {

                    beforeEach {
                        loginUseCaseMock.callAsNativeEmailPasswordReturnValue = { _, failure in
                            _ = failure(TestError.dummy, .shared)
                            return { .shared }
                        }
                        viewModel.login()
                    }

                    it("sets isLoading correctly") {
                        viewModel.$isLoading
                            .collect(2)
                            .expect([true, false])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets alertDescription correctly") {
                        expect(viewModel.alertDescription).toEventually(equal(TestError.dummy.alertDescription))
                    }
                }
            }
        }
    }
}
