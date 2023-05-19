//
//  SurveyQuestionScreenSpec.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 17/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared

@testable import KMMIC

final class SurveyQuestionScreenSpec: QuickSpec {

    override func spec() {

        describe("a SurveyQuestion screen") {

            var navigator: NavigatorMock!
            var viewModel: SurveyQuestionViewModelMock!
            var didSetScreen = false
            let displayTypeAndViewID: [[QuestionDisplayType]: ViewID.SurveyQuestion] = [
                [.heart, .star, .smiley]: .emojiAnswer,
                [.dropdown]: .dropdownAnswer,
                [.textfield, .textarea]: .formAnswer,
                [.choice]: .selectAnswer,
                [.nps]: .npsAnswer
            ]

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true
                navigator = .init()
                viewModel = .init(surveyDetail: .dummy, questionIndex: 0)
                viewModel.underlyingIsLast = false
                viewModel.underlyingSurveyQuestionUIModel = .init(
                    step: "step",
                    title: "title",
                    coverImageURL: nil,
                    displayType: .choice,
                    answers: []
                )
                self.app().setScreen(
                    screen: .surveyQuestion(viewModel: viewModel),
                    navigator: navigator
                )
            }

            it("has background image") {
                self.tester().waitForView(withViewID: .surveyQuestion(.backgroundImage))
            }

            it("has step text") {
                self.tester().waitForView(withViewID: .surveyQuestion(.stepText))
            }

            it("has question text") {
                self.tester().waitForView(withViewID: .surveyQuestion(.questionText))
            }

            it("has back button") {
                self.tester().waitForView(withViewID: .surveyQuestion(.backButton))
            }

            context("when it's the last question") {

                beforeEach {
                    viewModel.underlyingIsLast = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("shows submit button") {
                    self.tester().waitForView(withViewID: .surveyQuestion(.submitButton))
                }
            }

            context("when it's not the last question") {

                beforeEach {
                    viewModel.underlyingIsLast = false
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("shows next button") {
                    self.tester().waitForView(withViewID: .surveyQuestion(.nextButton))
                }
            }

            describe("its backButton tap") {

                beforeEach {
                    self.tester().tapView(withViewID: .surveyQuestion(.backButton))
                }

                it("triggers viewModel to call showExitAlert()") {
                    expect(viewModel.showExitAlertCalled) == true
                }
            }

            describe("its submitButton tap") {

                beforeEach {
                    viewModel.underlyingIsLast = true
                    viewModel.underlyingIsAllValid = true
                    viewModel.objectWillChange.send()
                    self.tester().tapView(withViewID: .surveyQuestion(.submitButton))
                }

                it("triggers viewModel to call submitSurvey()") {
                    expect(viewModel.submitSurveyCalled) == true
                }
            }

            describe("its nextButton tap") {

                let nextViewModel = SurveyQuestionViewModel(surveyDetail: .dummy, questionIndex: 0)
                beforeEach {
                    viewModel.getNextViewModelReturnValue = nextViewModel
                    viewModel.underlyingIsLast = false
                    viewModel.underlyingIsAllValid = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                    self.tester().tapView(withViewID: .surveyQuestion(.nextButton))
                }

                it("triggers navigator to show the next question") {
                    expect(navigator.showScreenByReceivedArguments?.screen)
                        == .surveyQuestion(
                            viewModel:
                            nextViewModel
                        )
                }
            }

            context("when viewModel.isLoading is true") {

                beforeEach {
                    viewModel.underlyingIsLoading = true
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                afterEach {
                    viewModel.underlyingIsLoading = false
                    viewModel.objectWillChange.send()
                    self.tester().waitForAnimationsToFinish()
                }

                it("shows Progress HUD") {
                    self.tester().waitForView(withViewID: .general(.progressHUD))
                }
            }

            for index in 0 ..< QuestionDisplayType.values().size {
                guard let displayType = QuestionDisplayType.values().get(index: index),
                      let viewID = displayTypeAndViewID.first(where: {
                          $0.key.contains(displayType)
                      })
                      .map({ $0.value })
                else { continue }
                context("when displayType is \(displayType)") {

                    beforeEach {
                        viewModel.underlyingSurveyQuestionUIModel = .init(
                            step: "step",
                            title: "title",
                            coverImageURL: nil,
                            displayType: displayType,
                            answers: []
                        )
                        viewModel.objectWillChange.send()
                    }

                    it("shows \(viewID)") {
                        self.tester().waitForView(withViewID: .surveyQuestion(viewID))
                    }
                }
            }
        }
    }
}
