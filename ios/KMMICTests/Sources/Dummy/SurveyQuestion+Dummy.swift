//
//  SurveyQuestion+Dummy.swift
//  KMMIC
//
//  Created by MarkG on 11/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

@testable import KMMIC

extension SurveyQuestion {

    static var dummy: SurveyQuestion { .dummy(id: "id", displayType: .heart) }

    static func dummy(id: String, displayType: QuestionDisplayType) -> SurveyQuestion {
        .init(
            id: id,
            text: "text",
            displayOrder: 1,
            displayType: displayType,
            pick: "pick",
            coverImageUrl: "https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d",
            answers: [
                .init(
                    id: "id",
                    text: "text",
                    displayOrder: 1,
                    inputMaskPlaceholder: "inputMaskPlaceholder"
                )
            ]
        )
    }
}
