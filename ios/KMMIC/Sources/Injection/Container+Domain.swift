//
//  Container+Domain.swift
//  KMMIC
//
//  Created by MarkG on 20/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Factory
import Shared

extension Container {

    var loginUseCase: Factory<LoginUseCase> {
        Factory(self) { LoginUseCaseImpl() }
    }

    var getCurrentUserUseCase: Factory<GetCurrentUserUseCase> {
        Factory(self) { GetCurrentUserUseCaseImpl() }
    }

    var getSurveysUseCase: Factory<GetSurveysUseCase> {
        Factory(self) { GetSurveysUseCaseImpl() }
    }

    var getSurveyUseCase: Factory<GetSurveyUseCase> {
        Factory(self) { GetSurveyUseCaseImpl() }
    }

    var submitSurveyUseCase: Factory<SubmitSurveyUseCase> {
        Factory(self) { SubmitSurveyUseCaseImpl() }
    }

    var dateHelper: Factory<DateHelperProtocol> {
        Factory(self) { DateHelper() }
    }

    var navigator: Factory<Navigator> {
        Factory(self) { Navigator() }.scope(.singleton)
    }
}
