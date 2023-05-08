package co.nimblehq.mark.kmmic.dummy

import co.nimblehq.mark.kmmic.data.service.api.serializer.Url
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel

internal val SurveyDetailApiModel.Companion.dummy
    get() = SurveyDetailApiModel(
        "id",
        "type",
        "title",
        "description",
        true,
        Url("https://www.example.com/image.png"),
        listOf()
    )
