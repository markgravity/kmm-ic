package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyQuestionApiModel

data class SurveyQuestion(
    val id: String,
    val text: String,
    val displayOrder: Int,
    val displayType: String,
    val pick: String,
    val coverImageUrl: String,
    val answers: List<SurveyAnswer>
) {
    val sortedAnswers: List<SurveyAnswer>
        get() = answers.sortedBy { it.displayOrder }
}
