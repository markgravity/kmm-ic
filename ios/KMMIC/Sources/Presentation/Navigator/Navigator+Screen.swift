//
//  Navigator+Screen.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

extension Navigator {

    enum Screen {

        case splash
        case login
        case home
        case surveyDetail(viewModel: SurveyDetailViewModel)
        case surveyQuestion(viewModel: SurveyQuestionViewModel)
    }
}
