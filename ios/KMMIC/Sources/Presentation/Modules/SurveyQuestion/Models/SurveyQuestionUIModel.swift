//
//  SurveyQuestionUIModel.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation
import Shared

struct SurveyQuestionUIModel: Equatable {

    let step: String
    let title: String
    let coverImageURL: URL?
    let displayType: QuestionDisplayType
    let answers: [SurveyAnswer]

    static func emojisForQuestionDisplayType(_ type: QuestionDisplayType) -> [String] {
        switch type {
        case .heart:
            return Array(repeating: Constants.Emoji.heart, count: 5)
        case .star:
            return Array(repeating: Constants.Emoji.star, count: 5)
        case .smiley:
            return [
                Constants.Emoji.poutingFace,
                Constants.Emoji.confusedFace,
                Constants.Emoji.neutralFace,
                Constants.Emoji.slightlySmilingFace,
                Constants.Emoji.grinningFaceWithSmilingEyes
            ]
        default:
            return []
        }
    }
}
