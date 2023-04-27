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

    internal constructor(surveyQuestionApiModel: SurveyQuestionApiModel) : this(
        surveyQuestionApiModel.id,
        surveyQuestionApiModel.text,
        surveyQuestionApiModel.displayOrder,
        surveyQuestionApiModel.displayType,
        surveyQuestionApiModel.pick,
        surveyQuestionApiModel.coverImageUrl.string,
        surveyQuestionApiModel.answers.map { SurveyAnswer(it) }
    )
}
