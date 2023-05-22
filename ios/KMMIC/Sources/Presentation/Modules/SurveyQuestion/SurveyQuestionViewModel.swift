//
//  SurveyQuestionViewModel.swift
//  KMMIC
//
//  Created by MarkG on 08/05/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Factory
import Shared

// sourcery: AutoMockable
class SurveyQuestionViewModel: ObservableObject {

    @Injected(\.submitSurveyUseCase) private var submitSurveyUseCase

    private let surveyDetail: SurveyDetail
    private let question: SurveyQuestion
    private var questionSubmissions: [SurveySubmissionQuestion]
    private var cancellableBag = Set<AnyCancellable>()

    @Published private var answerInputs = [SurveyAnswerInput]()
    @Published var surveyQuestionUIModel: SurveyQuestionUIModel
    @Published var isAllValid: Bool = false
    @Published var isLast: Bool
    @Published var isExitAlertPresented = false
    @Published var isLoading = false
    @Published var alertDescription: AlertDescription?
    @Published var didSubmitSurvey = false

    init(
        surveyDetail: SurveyDetail,
        questionIndex: Int,
        questionSubmissions: [SurveySubmissionQuestion] = []
    ) {
        let question = surveyDetail.questionsWithAvailableAnswers[questionIndex]
        surveyQuestionUIModel = .init(
            step: "\(questionIndex + 1)/\(surveyDetail.questionsWithAvailableAnswers.count)",
            title: question.text,
            coverImageURL: .init(string: question.coverImageUrl),
            displayType: question.displayType,
            answers: question.sortedAnswers.map {
                SurveyAnswerUIModel(answer: $0)
            }
        )
        self.surveyDetail = surveyDetail
        self.questionSubmissions = questionSubmissions
        self.question = question

        isLast = questionIndex == surveyDetail.questionsWithAvailableAnswers.count - 1
        $answerInputs
            .compactMap { [weak self] in self?.validate(answerInputs: $0) }
            .assign(to: &$isAllValid)
    }

    func setAnswerInput(for id: String, with content: String?) {
        clearAllAnswerInputs()
        let input = SurveyAnswerInput(id: id, content: content)
        answerInputs.append(input)
    }

    func setAnswerInputs(_ inputs: [SurveyAnswerInput]) {
        clearAllAnswerInputs()
        answerInputs.append(contentsOf: inputs)
    }

    func getNextViewModel() -> SurveyQuestionViewModel? {
        guard !isLast,
              let index = surveyDetail.questionsWithAvailableAnswers.firstIndex(where: {
                  $0.id == question.id
              }) else { return nil }

        let answers = answerInputs.map {
            SurveySubmissionAnswer(id: $0.id, answer: $0.content)
        }
        questionSubmissions.append(
            .init(id: question.id, answers: answers)
        )
        return .init(
            surveyDetail: surveyDetail,
            questionIndex: index + 1,
            questionSubmissions: questionSubmissions
        )
    }

    func showExitAlert() {
        isExitAlertPresented = true
    }

    func submitSurvey() {
        let submission = SurveySubmission(id: surveyDetail.id, questions: questionSubmissions)
        isLoading = true
        submitSurveyUseCase(submission: submission)
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case let .failure(error):
                    self.alertDescription = error.alertDescription
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                self.isLoading = false
                self.didSubmitSurvey = true
            }
            .store(in: &cancellableBag)
    }

    private func clearAllAnswerInputs() {
        answerInputs.removeAll()
    }

    private func validate(answerInputs: [SurveyAnswerInput]) -> Bool {
        switch question.displayType {
        case .dropdown, .heart, .star, .smiley, .nps, .textarea, .choice:
            return !answerInputs.isEmpty
        case .textfield:
            return surveyQuestionUIModel.answers.count == answerInputs.count
        default:
            return false
        }
    }
}
