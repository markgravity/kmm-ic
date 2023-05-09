//
//  SurveyQuestionViewModel.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory
import Shared

final class SurveyQuestionViewModel: ObservableObject {

    @Published var surveyQuestionUIModel: SurveyQuestionUIModel

    init(surveyDetail: SurveyDetail, questionIndex: Int) {
        let question = surveyDetail.questionsWithAvailableAnswers[questionIndex]
        surveyQuestionUIModel = .init(
            step: "\(questionIndex + 1)/\(surveyDetail.questions.count)",
            title: question.text,
            coverImageURL: .init(string: question.coverImageUrl)
        )
    }
}
