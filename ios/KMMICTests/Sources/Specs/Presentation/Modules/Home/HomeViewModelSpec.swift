//
//  HomeViewModelSpec.swift
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

final class HomeViewModelSpec: QuickSpec {

    override func spec() {

        var getCurrentUserUseCaseMock: GetCurrentUserUseCaseMock!
        var dateHelperMock: DateHelperProtocolMock!
        var viewModel: HomeViewModel!
        let todayDate = Date()

        describe("a HomeViewModel") {

            beforeEach {
                getCurrentUserUseCaseMock = .init()
                dateHelperMock = .init()
                Container.shared.getCurrentUserUseCase.register { getCurrentUserUseCaseMock }
                Container.shared.dateHelper
                    .register { dateHelperMock }

                dateHelperMock.underlyingToday = todayDate
                getCurrentUserUseCaseMock.invokeAsNativeReturnValue = { success, _ in
                    _ = success(.dummy, .shared)
                    return { .shared }
                }

                viewModel = HomeViewModel()
            }

            it("returns correct today date string") {
                let expectedString = DateFormatter.wideNameDayMonth
                    .string(from: todayDate)
                    .uppercased()
                expect(viewModel.todayDateString) == expectedString
            }

            context("when getCurrentUserUseCase emits success") {

                beforeEach {
                    getCurrentUserUseCaseMock.invokeAsNativeReturnValue = { success, _ in
                        _ = success(.dummy, .shared)
                        return { .shared }
                    }
                    viewModel = HomeViewModel()
                }

                it("sets userAvatarURL correctly") {
                    viewModel.$userAvatarURL
                        .collect(2)
                        .expect([nil, URL(string: User.dummy.avatarUrl)])
                        .waitForExpectations(timeout: 1.0)
                }
            }

            context("when getCurrentUserUseCase emits failure") {

                beforeEach {
                    getCurrentUserUseCaseMock.invokeAsNativeReturnValue = { _, failure in
                        _ = failure(TestError.dummy, .shared)
                        return { .shared }
                    }
                    viewModel = HomeViewModel()
                }

                it("sets userAvatarURL correctly") {
                    viewModel.$userAvatarURL
                        .collect(2)
                        .expect([nil, nil])
                        .waitForExpectations(timeout: 1.0)
                }
            }
        }
    }
}
