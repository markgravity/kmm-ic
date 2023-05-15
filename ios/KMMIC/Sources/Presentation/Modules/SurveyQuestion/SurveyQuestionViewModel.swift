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

final class SurveyQuestionViewModel: ObservableObject {

    private let surveyDetail: SurveyDetail
    private let question: SurveyQuestion
    private var questionSubmissions: [SurveySubmissionQuestion]
    private var cancellableBag = Set<AnyCancellable>()

    @Published private var answerInputs = [SurveyAnswerInput]()
    @Published var surveyQuestionUIModel: SurveyQuestionUIModel
    @Published var isAllValid: Bool = false
    @Published var isLast: Bool

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
