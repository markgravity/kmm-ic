//
//  SurveyDetailScreenSpec.swift
//  KMMICTests
//
//  Created by MarkG on 19/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Nimble
import Quick
import Shared
import SwiftUI
import ViewInspector

@testable import KMMIC

final class SurveyDetailScreenSpec: QuickSpec {

    override func spec() {
        var navigator: NavigatorMock!
        var viewModel: SurveyDetailViewModelMock!
        var screen: some View {
            SurveyDetailScreen()
                .environmentObject(viewModel)
                .environmentObject(navigator)
        }
        let survey = Survey.dummy
        let surveyUIModel = SurveyDetailUIModel(survey: survey)

        describe("a SurveyDetail screen") {

            beforeEach {
                navigator = .init()
                viewModel = .init(survey: survey)
                viewModel.underlyingSurvey = surveyUIModel
            }

            it("shows background image with correct image url") {
                let view = try screen
                    .inspect()
                    .find(DarkBackground.self, withViewID: .surveyDetail(.backgroundImage))
                    .actualView()
                expect(view.url) == surveyUIModel.coverImageURL
            }

            it("show title correctly") {
                let text = try screen
                    .inspect()
                    .find(viewWithViewID: .surveyDetail(.titleText))
                    .text()
                    .string()
                expect(text) == surveyUIModel.title
            }

            it("shows description correctly") {
                let text = try screen
                    .inspect()
                    .find(viewWithViewID: .surveyDetail(.descriptionText))
                    .text()
                    .string()
                expect(text) == surveyUIModel.description
            }

            it("shows back button") {
                let view = try screen
                    .inspect()
                    .find(viewWithViewID: .surveyDetail(.backButton))
                expect(view.isAbsent) == false
            }

            it("has start button") {
                let view = try screen
                    .inspect()
                    .find(viewWithViewID: .surveyDetail(.startButton))
                expect(view.isAbsent) == false
            }

            describe("its onAppear call") {

                beforeEach {
                    try! screen.inspect().zStack().callOnAppear()
                }

                it("triggers viewModel to call fetch()") {
                    expect(viewModel.fetchCalled) == true
                }
            }

            context("when viewModel.isLoading is true") {

                beforeEach {
                    viewModel.underlyingIsLoading = true
                }

                it("shows Progress HUD") {
                    let view = try screen.inspect()
                        .find(ProgressHUD.self, withViewID: .general(.progressHUD))
                    expect(view.isAbsent) == false
                }
            }

            describe("its start button tap") {

                let surveyQuestionViewModel = SurveyQuestionViewModel(surveyDetail: .dummy, questionIndex: 0)

                beforeEach {
                    viewModel.surveyQuestionViewModel = surveyQuestionViewModel
                    try! screen.inspect()
                        .find(viewWithViewID: .surveyDetail(.startButton))
                        .button()
                        .tap()
                }

                it("triggers navigator to show SurveyQuestion screen") {
                    expect(navigator.showScreenByReceivedArguments?.screen)
                        == .surveyQuestion(viewModel: surveyQuestionViewModel)
                }
            }

            describe("its back button tap") {

                beforeEach {
                    try! screen.inspect()
                        .find(viewWithViewID: .surveyDetail(.backButton))
                        .button()
                        .tap()
                }

                it("triggers navigator to go back") {
                    expect(navigator.goBackCalled) == true
                }
            }
        }
    }
}
