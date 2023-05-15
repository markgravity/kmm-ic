//
//  SurveyAnswerUIModel.swift
//  KMMIC
//
//  Created by MarkG on 11/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation
import Shared

struct SurveyAnswerUIModel: Equatable {

    let id: String
    let text: String
    let placeholder: String

    init(answer: SurveyAnswer) {
        id = answer.id
        text = answer.text.string
        placeholder = answer.inputMaskPlaceholder.string
    }
}
