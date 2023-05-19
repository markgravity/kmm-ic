//
//  HomeViewModel.swift
//  KMMIC
//
//  Created by MarkG on 24/04/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory
import Shared

final class HomeViewModel: ObservableObject {

    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    @Injected(\.getSurveysUseCase) private var getSurveysUseCase
    @Injected(\.dateHelper) private var dateHelper

    private var cancellableBag = Set<AnyCancellable>()

    @Published var todayDateString: String = ""
    @Published var userAvatarURL: URL?
    @Published var surveys = [HomeSurveyUIModel]()
    @Published var alertDescription: AlertDescription?
    @Published var isLoading = false
    @Published var isRefreshing = false
    @Published var selectedSurveyIndex = 0

    var selectedSurvey: HomeSurveyUIModel? {
        guard selectedSurveyIndex < surveys.count else { return nil }
        return surveys[selectedSurveyIndex]
    }

    var canSelectPreviousSurvey: Bool { selectedSurveyIndex > 0 }

    var canSelectNextSurvey: Bool { selectedSurveyIndex < surveys.count - 1 }

    init() {
        todayDateString = DateFormatter.wideNameDayMonth
            .string(from: dateHelper.today).uppercased()

        getCurrentUserUseCase()
            .receive(on: RunLoop.main)
            .map { URL(string: $0.avatarUrl) }
            .replaceError(with: nil)
            .assign(to: &$userAvatarURL)
    }

    func fetch() {
        getSurveys(isRefresh: false)
    }

    func refresh() {
        guard !isLoading else { return }
        getSurveys(isRefresh: true)
    }

    func selectNextSurvey() {
        guard canSelectNextSurvey else { return }
        selectedSurveyIndex += 1
    }

    func selectPreviousSurvey() {
        guard canSelectPreviousSurvey else { return }
        selectedSurveyIndex -= 1
    }

    private func getSurveys(isRefresh: Bool) {
        updateLoadingState(isRefresh: isRefresh, value: true)
        getSurveysUseCase(pageNumber: 1, pageSize: 5, isRefresh: isRefresh)
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self else { return }
                self.updateLoadingState(isRefresh: isRefresh, value: false)
                switch result {
                case let .failure(error):
                    self.alertDescription = error.alertDescription
                case .finished: break
                }
            } receiveValue: { [weak self] surveys in
                guard let self else { return }
                self.updateLoadingState(isRefresh: isRefresh, value: false)
                self.surveys = surveys.map { .init(survey: $0) }
                self.selectedSurveyIndex = 0
            }
            .store(in: &cancellableBag)
    }

    private func updateLoadingState(isRefresh: Bool, value: Bool) {
        if isRefresh {
            isRefreshing = value
        } else {
            isLoading = value
        }
    }
}
