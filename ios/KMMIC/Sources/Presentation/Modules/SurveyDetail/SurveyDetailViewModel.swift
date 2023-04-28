//
//  SurveyDetailViewModel.swift
//  KMMIC
//
//  Created by MarkG on 28/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory
import Shared

final class SurveyDetailViewModel: ObservableObject {

    @Injected(\.getSurveyUseCase) private var getSurveyUseCase

    private var cancellableBag = Set<AnyCancellable>()

    @Published var survey: SurveyDetailUIModel
    @Published var alertDescription: AlertDescription?
    @Published var isLoading = false

    init(survey: Survey) {
        self.survey = .init(survey: survey)
    }

    func fetch() {
        isLoading = true
        getSurveyUseCase(id: survey.id)
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case let .failure(error):
                    self.alertDescription = error.alertDescription
                case .finished: break
                }
            } receiveValue: { [weak self] detail in
                guard let self else { return }
                self.isLoading = false
                self.survey = .init(surveyDetail: detail)
            }
            .store(in: &cancellableBag)
    }
}
