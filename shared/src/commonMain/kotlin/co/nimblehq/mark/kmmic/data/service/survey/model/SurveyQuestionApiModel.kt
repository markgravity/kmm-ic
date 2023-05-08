package co.nimblehq.mark.kmmic.data.service.survey.model

import co.nimblehq.mark.kmmic.data.service.api.serializer.Url
import co.nimblehq.mark.kmmic.domain.model.QuestionDisplayType
import co.nimblehq.mark.kmmic.domain.model.SurveyQuestion
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class SurveyQuestionApiModel(
    @SerialName("id")
    val id: String,
    @SerialName("text")
    val text: String,
    @SerialName("display_order")
    val displayOrder: Int,
    @SerialName("display_type")
    val displayType: String,
    @SerialName("pick")
    val pick: String,
    @SerialName("cover_image_url")
    val coverImageUrl: Url,
    @SerialName("answers")
    val answers: List<SurveyAnswerApiModel>
)

fun SurveyQuestionApiModel.toSurveyQuestion() = SurveyQuestion(
    id,
    text,
    displayOrder,
    QuestionDisplayType.valueOf(displayType.uppercase()),
    pick,
    coverImageUrl.string,
    answers.map { it.toAnswer() }
)
