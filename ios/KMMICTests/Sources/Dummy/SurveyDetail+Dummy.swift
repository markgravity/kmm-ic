//
//  Survey+Dummy.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

@testable import KMMIC

extension SurveyDetail {

    static var dummy: SurveyDetail { .dummy(questions: [.dummy]) }

    static func dummy(questions: [SurveyQuestion]) -> SurveyDetail {
        return .init(
            id: "id",
            title: "title",
            description: "description",
            isActive: true,
            coverImageUrl: "https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d",
            questions: questions
        )
    }
}
