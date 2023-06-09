package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel

data class SurveyDetail(
    val id: String,
    val title: String,
    val description: String,
    val isActive: Boolean,
    val coverImageUrl: String,
    val questions: List<SurveyQuestion>
)

val SurveyDetail.questionsWithAvailableAnswers: List<SurveyQuestion>
    get() = questions.filter {
        it.displayType != QuestionDisplayType.INTRO && it.displayType != QuestionDisplayType.OUTRO
    }
