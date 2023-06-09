//
//  HomeSurveyUIModel.swift
//  KMMIC
//
//  Created by MarkG on 26/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Shared

struct HomeSurveyUIModel: Equatable {

    let survey: Survey
    let title: String
    let description: String
    let coverImageURL: URL?

    init(survey: Survey) {
        self.survey = survey
        title = survey.title
        description = survey.description_
        coverImageURL = .init(string: survey.coverImageUrl)
    }
}
