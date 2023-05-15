package co.nimblehq.mark.kmmic.domain.model

data class SurveySubmission(
    val id: String,
    val questions: List<SurveySubmissionQuestion>
)

data class SurveySubmissionQuestion(
    val id: String,
    val answers: List<SurveySubmissionAnswer>
)

data class SurveySubmissionAnswer(
    val id: String,
    val answer: String? = null
)
