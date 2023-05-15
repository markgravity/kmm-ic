package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyAnswerApiModel

data class SurveyAnswer(
    val id: String,
    val text: String?,
    val displayOrder: Int,
    var inputMaskPlaceholder: String?
)
