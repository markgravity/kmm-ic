package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel

data class SurveyDetail(
    val id: String,
    val title: String,
    val description: String,
    val isActive: Boolean,
    val coverImageUrl: String,
    val questions: List<SurveyQuestion>
) {
    internal constructor(surveyDetailApiModel: SurveyDetailApiModel) : this(
        surveyDetailApiModel.id,
        surveyDetailApiModel.title,
        surveyDetailApiModel.description,
        surveyDetailApiModel.isActive,
        surveyDetailApiModel.coverImageUrl.string,
        surveyDetailApiModel.questions.map { SurveyQuestion(it) }
    )
}
