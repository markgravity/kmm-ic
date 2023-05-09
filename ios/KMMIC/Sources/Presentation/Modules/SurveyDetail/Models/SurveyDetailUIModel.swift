//
//  SurveyDetailUIModel.swift
//  KMMIC
//
//  Created by MarkG on 28/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

struct SurveyDetailUIModel: Equatable {

    let id: String
    let title: String
    let description: String
    let coverImageURL: URL?

    init(surveyDetail: SurveyDetail) {
        id = surveyDetail.id
        title = surveyDetail.title
        description = surveyDetail.description_
        coverImageURL = .init(string: surveyDetail.coverImageUrl)
    }

    init(survey: Survey) {
        id = survey.id
        title = survey.title
        description = survey.description_
        coverImageURL = .init(string: survey.coverImageUrl)
    }
}
