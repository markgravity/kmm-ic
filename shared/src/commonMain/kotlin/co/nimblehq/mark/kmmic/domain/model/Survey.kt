package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.cached.survey.model.CachedSurvey
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import kotlinx.serialization.Serializable

@Serializable
data class Survey(
    val id: String,
    val title: String,
    val description: String,
    val isActive: Boolean,
    val coverImageUrl: String
) {
    internal constructor(surveyApiModel: SurveyApiModel) : this(
        surveyApiModel.id,
        surveyApiModel.title,
        surveyApiModel.description,
        surveyApiModel.isActive,
        surveyApiModel.coverImageUrl.string
    )

    internal constructor(cachedSurvey: CachedSurvey) : this(
        cachedSurvey.id,
        cachedSurvey.title,
        cachedSurvey.description,
        cachedSurvey.isActive,
        cachedSurvey.coverImageUrl
    )
}
