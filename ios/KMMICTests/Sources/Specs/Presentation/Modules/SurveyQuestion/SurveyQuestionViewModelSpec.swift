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
        var viewModel: SurveyQuestionViewModel!
        let question = SurveyDetail.dummy.questions.first

        describe("a SurveyQuestionViewModel") {

            beforeEach {
                viewModel = SurveyQuestionViewModel(
                    surveyDetail: .dummy,
                    questionIndex: 0
                )
            }

            it("returns survey correctly") {
                expect(viewModel.surveyQuestionUIModel) == SurveyQuestionUIModel(
                    step: "1/1",
                    title: question?.text ?? "",
                    coverImageURL: .init(string: question?.coverImageUrl ?? "")
                )
            }
        }
    }
}
