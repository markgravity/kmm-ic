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
        var getSurveysUseCaseMock: GetSurveysUseCaseMock!
        var dateHelperMock: DateHelperProtocolMock!
        var viewModel: HomeViewModel!
        let todayDate = Date()
        let dummySurveyUIModel = HomeSurveyUIModel(survey: .dummy)

        describe("a HomeViewModel") {

            beforeEach {
                getCurrentUserUseCaseMock = .init()
                getSurveysUseCaseMock = .init()
                dateHelperMock = .init()
                Container.shared.getCurrentUserUseCase.register { getCurrentUserUseCaseMock }
                Container.shared.getSurveysUseCase.register { getSurveysUseCaseMock }
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

            context("when selectedSurveyIndex is at the first") {
                beforeEach {
                    viewModel.surveys = [dummySurveyUIModel, dummySurveyUIModel]
                    viewModel.selectedSurveyIndex = 0
                }

                it("returns correct canSelectPreviousSurvey") {
                    expect(viewModel.canSelectPreviousSurvey) == false
                }

                it("returns correct canSelectNextSurvey") {
                    expect(viewModel.canSelectNextSurvey) == true
                }
            }

            context("when selectedSurveyIndex is not at the first") {

                beforeEach {
                    viewModel.surveys = [dummySurveyUIModel, dummySurveyUIModel]
                    viewModel.selectedSurveyIndex = 1
                }

                it("returns correct canSelectPreviousSurvey") {
                    expect(viewModel.canSelectPreviousSurvey) == true
                }

                it("returns correct canSelectNextSurvey") {
                    expect(viewModel.canSelectNextSurvey) == false
                }
            }

            describe("its fetch() call") {

                context("when getSurveysUseCase emits success") {

                    beforeEach {
                        getSurveysUseCaseMock.invokeAsNativePageNumberPageSizeIsRefreshReturnValue = { success, _ in
                            _ = success([.dummy], .shared)
                            return { .shared }
                        }
                        viewModel.fetch()
                    }

                    it("sets surveys correctly") {
                        viewModel.$surveys
                            .collect(2)
                            .expect([[], [.init(survey: .dummy)]])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets isLoading correctly") {
                        viewModel.$isLoading
                            .collect(2)
                            .expect([true, false])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets selectedSurveyIndex to zero") {
                        viewModel.$selectedSurveyIndex
                            .collect(2)
                            .expect([0, 0])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("triggers getSurveysUseCase to call without refreshing") {
                        expect(
                            getSurveysUseCaseMock
                                .invokeAsNativePageNumberPageSizeIsRefreshReceivedArguments?
                                .isRefresh
                        ) == false
                    }

                    it("returns correct selectedSurvey") {
                        expect(viewModel.selectedSurvey).toEventually(equal(dummySurveyUIModel))
                    }
                }

                context("when getSurveysUseCase emits failure") {

                    beforeEach {
                        getSurveysUseCaseMock.invokeAsNativePageNumberPageSizeIsRefreshReturnValue = { _, failure in
                            _ = failure(TestError.dummy, .shared)
                            return { .shared }
                        }
                        viewModel.fetch()
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

            describe("its refresh() call") {

                context("when getSurveysUseCase emits success") {

                    beforeEach {
                        getSurveysUseCaseMock.invokeAsNativePageNumberPageSizeIsRefreshReturnValue = { success, _ in
                            _ = success([.dummy], .shared)
                            return { .shared }
                        }
                        viewModel.refresh()
                    }

                    it("sets surveys correctly") {
                        viewModel.$surveys
                            .collect(2)
                            .expect([[], [dummySurveyUIModel]])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets isLoading correctly") {
                        viewModel.$isLoading
                            .collect(2)
                            .expect([true, false])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets selectedSurveyIndex to zero") {
                        viewModel.$selectedSurveyIndex
                            .collect(2)
                            .expect([0, 0])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("triggers getSurveysUseCase to call with refreshing") {
                        expect(
                            getSurveysUseCaseMock
                                .invokeAsNativePageNumberPageSizeIsRefreshReceivedArguments?
                                .isRefresh
                        ) == true
                    }

                    it("returns correct selectedSurvey") {
                        expect(viewModel.selectedSurvey).toEventually(equal(dummySurveyUIModel))
                    }
                }

                context("when getSurveysUseCase emits failure") {

                    beforeEach {
                        getSurveysUseCaseMock.invokeAsNativePageNumberPageSizeIsRefreshReturnValue = { _, failure in
                            _ = failure(TestError.dummy, .shared)
                            return { .shared }
                        }
                        viewModel.refresh()
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

            describe("its selectNextSurvey() call") {

                beforeEach {
                    viewModel.surveys = [dummySurveyUIModel, dummySurveyUIModel]
                    viewModel.selectNextSurvey()
                }

                it("triggers to increase selectedSurveyIndex by 1") {
                    expect(viewModel.selectedSurveyIndex) == 1
                }
            }

            describe("its selectPreviousSurvey() call") {

                beforeEach {
                    viewModel.surveys = [dummySurveyUIModel, dummySurveyUIModel]
                    viewModel.selectNextSurvey()
                    viewModel.selectPreviousSurvey()
                }

                it("triggers to decrease selectedSurveyIndex by 1") {
                    expect(viewModel.selectedSurveyIndex) == 0
                }
            }
        }
    }
}
