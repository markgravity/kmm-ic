package co.nimblehq.mark.kmmic.data.service.cached.survey.model

import co.nimblehq.mark.kmmic.domain.model.Survey
import io.realm.kotlin.types.RealmObject
import io.realm.kotlin.types.annotations.PrimaryKey

@Suppress("LongParameterList")
internal class CachedSurvey() : RealmObject {

    @PrimaryKey
    var id: String = ""
    var type: String = ""
    var title: String = ""
    var description: String = ""
    var isActive: Boolean = false
    var coverImageUrl: String = ""

    constructor(
        id: String,
        type: String,
        title: String,
        description: String,
        isActive: Boolean,
        coverImageUrl: String
    ) : this() {
        this.id = id
        this.type = type
        this.title = title
        this.description = description
        this.isActive = isActive
        this.coverImageUrl = coverImageUrl
    }
}

internal fun CachedSurvey.toSurvey() = Survey(
    id,
    title,
    description,
    isActive,
    coverImageUrl
)
