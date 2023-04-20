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

            describe("its login call") {

                beforeEach {
                    viewModel.email = "dev@nimblehq.co"
                    viewModel.password = "12345678"
                }

                context("when logInUseCase emits success") {

                    beforeEach {
                        loginUseCaseMock.callAsNativeEmailPasswordReturnValue = { success, _ in
                            {
                                success(
                                    .init(accessToken: "", tokenType: "", expiresIn: 2, refreshToken: "", createdAt: 2),
                                    .shared
                                )
                                return .shared
                            }
                        }
                        viewModel.login()
                    }

                    it("sets isLoading to true") {
                        expect(viewModel.isLoading) == true
                    }
                }
            }
        }
    }
}
