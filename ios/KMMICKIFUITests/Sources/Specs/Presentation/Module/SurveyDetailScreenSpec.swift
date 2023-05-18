//
//  SurveyDetailScreenSpec.swift
//  KMMICKIFUITests
//
//  Created by MarkG on 16/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick

@testable import KMMIC

final class SurveyDetailScreenSpec: QuickSpec {

    override func spec() {

        describe("a SurveyDetail screen") {

            var navigator: NavigatorMock!
            var viewModel: SurveyDetailViewModelMock!
            var didSetScreen = false

            beforeEach {
                guard !didSetScreen else { return }
                didSetScreen = true
                navigator = .init()
                viewModel = .init(survey: .dummy)
                viewModel.underlyingSurvey = .init(survey: .dummy)

                self.app().setScreen(
                    screen: .surveyDetail(viewModel: viewModel),
                    navigator: navigator
                )
            }

            it("has background image") {
                self.tester().waitForView(withViewID: .surveyDetail(.backgroundImage))
            }

            it("has title") {
                self.tester().waitForView(withViewID: .surveyDetail(.titleText))
            }

            it("has description") {
                self.tester().waitForView(withViewID: .surveyDetail(.descriptionText))
            }

            it("has back button") {
                self.tester().waitForView(withViewID: .surveyDetail(.backButton))
            }

            it("has start button") {
                self.tester().waitForView(withViewID: .surveyDetail(.startButton))
            }

            it("triggers viewModel to call fetch()") {
                expect(viewModel.fetchCalled).toEventually(beTrue())
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

            describe("its start button tap") {

                let surveyQuestionViewModel = SurveyQuestionViewModel(surveyDetail: .dummy, questionIndex: 0)

                beforeEach {
                    viewModel.surveyQuestionViewModel = surveyQuestionViewModel
                    self.tester().tapView(withViewID: .surveyDetail(.startButton))
                }

                it("triggers navigator to show SurveyQuestion screen") {
                    expect(navigator.showScreenByReceivedArguments?.screen)
                        == .surveyQuestion(viewModel: surveyQuestionViewModel)
                }
            }

            describe("its back button tap") {

                beforeEach {
                    self.tester().tapView(withViewID: .surveyDetail(.backButton))
                }

                it("triggers navigator to go back") {
                    expect(navigator.goBackCalled) == true
                }
            }
        }
    }
}
