package co.nimblehq.mark.kmmic.data.service.survey.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal data class GetSurveysParams(
    @SerialName("page[number]")
    val pageNumber: Int,
    @SerialName("page[size]")
    val pageSize: Int
)
