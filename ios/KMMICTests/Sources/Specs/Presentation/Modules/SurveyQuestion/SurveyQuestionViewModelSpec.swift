//
//  SurveyQuestionViewModelSpec.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared
import TestableCombinePublishers

@testable import KMMIC

final class SurveyQuestionViewModelSpec: QuickSpec {

    override func spec() {
        var submitSurveyUseCase: SubmitSurveyUseCaseMock!
        var viewModel: SurveyQuestionViewModel!
        let question = SurveyDetail.dummy.questions.first

        describe("a SurveyQuestionViewModel") {

            beforeEach {
                submitSurveyUseCase = .init()
                Container.shared.submitSurveyUseCase.register { submitSurveyUseCase }

                viewModel = SurveyQuestionViewModel(
                    surveyDetail: .dummy,
                    questionIndex: 0
                )
            }

            it("returns survey correctly") {
                expect(viewModel.surveyQuestionUIModel) == SurveyQuestionUIModel(
                    step: "1/1",
                    title: question?.text ?? "",
                    coverImageURL: .init(string: question?.coverImageUrl ?? ""),
                    displayType: QuestionDisplayType.heart,
                    answers: question?.answers.map {
                        .init(answer: $0)
                    } ?? []
                )
            }

            describe("its isLast") {

                context("when it's the last question") {

                    beforeEach {
                        viewModel = SurveyQuestionViewModel(
                            surveyDetail: .dummy,
                            questionIndex: 0
                        )
                    }

                    it("returns isLast correctly") {
                        expect(viewModel.isLast) == true
                    }
                }

                context("when it's not the last question") {

                    let surveyDetail = SurveyDetail.dummy(questions: [
                        .dummy(id: "1", displayType: .choice),
                        .dummy(id: "2", displayType: .dropdown)
                    ])

                    beforeEach {
                        viewModel = SurveyQuestionViewModel(
                            surveyDetail: surveyDetail,
                            questionIndex: 0
                        )
                    }

                    it("returns isLast correctly") {
                        expect(viewModel.isLast) == false
                    }
                }
            }

            describe("its isAllValid") {
                let displayTypes: [QuestionDisplayType] = [.dropdown, .heart, .star, .smiley, .nps, .textarea, .choice]
                for displayType in displayTypes {
                    let surveyDetail = SurveyDetail.dummy(questions: [
                        .dummy(id: "1", displayType: displayType)
                    ])
                    context("when displayType is \(displayType)") {

                        context("when answer inputs are empty") {

                            beforeEach {
                                viewModel = SurveyQuestionViewModel(
                                    surveyDetail: surveyDetail,
                                    questionIndex: 0
                                )
                            }

                            it("returns isAllValid correctly") {
                                expect(viewModel.isAllValid) == false
                            }
                        }

                        context("when answer inputs are not empty") {

                            beforeEach {
                                viewModel = SurveyQuestionViewModel(
                                    surveyDetail: surveyDetail,
                                    questionIndex: 0
                                )
                                viewModel.setAnswerInput(for: "", with: nil)
                            }

                            it("returns isAllValid correctly") {
                                expect(viewModel.isAllValid) == true
                            }
                        }
                    }
                }

                context("when displayType is textfield") {
                    let surveyDetail = SurveyDetail.dummy(questions: [
                        .dummy(id: "1", displayType: .textfield)
                    ])
                    context("when answer inputs are empty") {

                        beforeEach {
                            viewModel = SurveyQuestionViewModel(
                                surveyDetail: surveyDetail,
                                questionIndex: 0
                            )
                        }

                        it("returns isAllValid correctly") {
                            expect(viewModel.isAllValid) == false
                        }
                    }

                    context("when answer inputs are not empty") {

                        beforeEach {
                            viewModel = SurveyQuestionViewModel(
                                surveyDetail: surveyDetail,
                                questionIndex: 0
                            )
                            viewModel.setAnswerInputs(
                                surveyDetail.questions.first?.answers.map {
                                    .init(id: $0.id, content: $0.text)
                                } ?? []
                            )
                        }

                        it("returns isAllValid correctly") {
                            expect(viewModel.isAllValid) == true
                        }
                    }
                }
            }

            describe("its getNextViewModel call") {

                context("when isLast is true") {

                    var output: SurveyQuestionViewModel?

                    beforeEach {
                        viewModel = SurveyQuestionViewModel(
                            surveyDetail: .dummy,
                            questionIndex: 0
                        )
                        output = viewModel.getNextViewModel()
                    }

                    it("returns nil") {
                        expect(output) == nil
                    }
                }

                context("when isLast is false") {

                    let surveyDetail = SurveyDetail.dummy(questions: [
                        .dummy(id: "1", displayType: .choice),
                        .dummy(id: "2", displayType: .dropdown)
                    ])
                    var output: SurveyQuestionViewModel?

                    beforeEach {
                        viewModel = SurveyQuestionViewModel(
                            surveyDetail: surveyDetail,
                            questionIndex: 0
                        )
                        output = viewModel.getNextViewModel()
                    }

                    it("returns the next view model") {
                        expect(output) != nil
                    }
                }
            }

            describe("its showExitAlert call") {

                beforeEach {
                    viewModel.showExitAlert()
                }

                it("returns isExitAlertPresented correctly") {
                    expect(viewModel.isExitAlertPresented) == true
                }
            }

            describe("its submitSurvey call") {

                context("when submitSurveyUseCase emits success") {

                    beforeEach {
                        submitSurveyUseCase.invokeAsNativeSubmissionReturnValue = { success, _ in
                            _ = success(.shared, .shared)
                            return { .shared }
                        }
                        viewModel.submitSurvey()
                    }

                    it("sets isLoading correctly") {
                        viewModel.$isLoading
                            .collect(2)
                            .expect([true, false])
                            .waitForExpectations(timeout: 1.0)
                    }

                    it("sets didSubmitSurvey correctly") {
                        viewModel.$didSubmitSurvey
                            .collect(2)
                            .expect([false, true])
                            .waitForExpectations(timeout: 1.0)
                    }
                }

                context("when submitSurveyUseCase emits failure") {

                    beforeEach {
                        submitSurveyUseCase.invokeAsNativeSubmissionReturnValue = { _, failure in
                            _ = failure(TestError.dummy, .shared)
                            return { .shared }
                        }
                        viewModel.submitSurvey()
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
