package co.nimblehq.mark.kmmic.data.service.survey.model

import co.nimblehq.mark.kmmic.data.service.api.serializer.Url
import co.nimblehq.mark.kmmic.domain.model.SurveyDetail
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal data class SurveyDetailApiModel(
    @SerialName("id")
    val id: String,
    @SerialName("type")
    val type: String,
    @SerialName("title")
    val title: String,
    @SerialName("description")
    val description: String,
    @SerialName("is_active")
    val isActive: Boolean,
    @SerialName("cover_image_url")
    val coverImageUrl: Url,
    @SerialName("questions")
    val questions: List<SurveyQuestionApiModel>
)

internal fun SurveyDetailApiModel.toSurveyDetail() = SurveyDetail(
    id,
    title,
    description,
    isActive,
    coverImageUrl.string,
    questions.map { it.toSurveyQuestion() }
)
