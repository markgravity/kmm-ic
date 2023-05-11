package co.nimblehq.mark.kmmic.data.service.survey.model

import co.nimblehq.mark.kmmic.domain.model.SurveySubmission
import co.nimblehq.mark.kmmic.domain.model.SurveySubmissionAnswer
import co.nimblehq.mark.kmmic.domain.model.SurveySubmissionQuestion
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal data class SurveySubmissionParams(
    @SerialName("survey_id")
    val surveyId: String,
    @SerialName("questions")
    val questions: List<SurveySubmissionQuestionParams>
) {
    constructor(surveySubmission: SurveySubmission) : this(
        surveySubmission.id,
        surveySubmission.questions.map(::SurveySubmissionQuestionParams)
    )
}

@Serializable
internal data class SurveySubmissionQuestionParams(
    @SerialName("id")
    val id: String,
    @SerialName("answers")
    val answers: List<SurveySubmissionAnswerParams>
) {
    constructor(questionSubmission: SurveySubmissionQuestion) : this(
        questionSubmission.id,
        questionSubmission.answers.map(::SurveySubmissionAnswerParams)
    )
}

@Serializable
internal data class SurveySubmissionAnswerParams(
    @SerialName("id")
    val id: String,
    @SerialName("answer")
    val answer: String?
) {
    constructor(answerSubmission: SurveySubmissionAnswer) : this(
        answerSubmission.id,
        answerSubmission.answer
    )
}
