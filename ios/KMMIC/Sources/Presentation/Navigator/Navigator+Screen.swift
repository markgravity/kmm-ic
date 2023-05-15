//
//  Navigator+Screen.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

extension Navigator {

    enum Screen: Equatable {

        case splash
        case login
        case home
        case surveyDetail(viewModel: SurveyDetailViewModel)
        case surveyQuestion(viewModel: SurveyQuestionViewModel)
        case thank

        private var name: String {
            switch self {
            case .splash:
                return "splash"
            case .login:
                return "login"
            case .home:
                return "home"
            case .surveyDetail:
                return "surveyDetail"
            case .surveyQuestion:
                return "surveyQuestion"
            case .thank:
                return "thank"
            }
        }

        static func == (lhs: Navigator.Screen, rhs: Navigator.Screen) -> Bool {
            lhs.name == rhs.name
        }
    }
}
