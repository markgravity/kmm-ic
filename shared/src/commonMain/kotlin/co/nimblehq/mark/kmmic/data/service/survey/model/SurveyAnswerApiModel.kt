package co.nimblehq.mark.kmmic.data.service.survey.model

import co.nimblehq.mark.kmmic.domain.model.SurveyAnswer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class SurveyAnswerApiModel(
    @SerialName("id")
    val id: String,
    @SerialName("text")
    val text: String?,
    @SerialName("display_order")
    val displayOrder: Int,
    @SerialName("input_mask_placeholder")
    var inputMaskPlaceholder: String?
)

fun SurveyAnswerApiModel.toAnswer() = SurveyAnswer(id, text, displayOrder, inputMaskPlaceholder)
