//
//  SurveyDetailViewModelSpec.swift
//  KMMIC
//
//  Created by MarkG on 28/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared
import TestableCombinePublishers

@testable import KMMIC

final class SurveyDetailViewModelSpec: QuickSpec {

    override func spec() {
        var getSurveyUseCaseMock: GetSurveyUseCaseMock!
        var viewModel: SurveyDetailViewModel!
        let dummySurveyUIModel = HomeSurveyUIModel(survey: .dummy)

        describe("a SurveyDetailViewModel") {

            beforeEach {
                getSurveyUseCaseMock = .init()
                Container.shared.getSurveyUseCase.register { getSurveyUseCaseMock }

                viewModel = SurveyDetailViewModel(survey: .dummy)
            }

            it("returns survey correctly") {
                expect(viewModel.survey) == SurveyDetailUIModel(survey: .dummy)
            }

            describe("its fetch call") {

                context("when getSurveyUseCase emits success") {

                    beforeEach {
                        getSurveyUseCaseMock.invokeAsNativeIdReturnValue = { success, _ in
                            _ = success(.dummy, .shared)
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

                    it("sets survey correctly") {
                        viewModel.$survey
                            .collect(2)
                            .expect([
                                SurveyDetailUIModel(survey: .dummy),
                                SurveyDetailUIModel(surveyDetail: .dummy)
                            ])
                            .waitForExpectations(timeout: 1.0)
                    }
                }

                context("when logInUseCase emits failure") {

                    beforeEach {
                        getSurveyUseCaseMock.invokeAsNativeIdReturnValue = { _, failure in
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
        }
    }
}
