package co.nimblehq.mark.kmmic.data.service.cached.survey.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import io.realm.kotlin.types.RealmObject
import io.realm.kotlin.types.annotations.PrimaryKey

internal class CachedSurvey() : RealmObject {

    @PrimaryKey
    var id: String = ""
    var type: String = ""
    var title: String = ""
    var description: String = ""
    var isActive: Boolean = false
    var coverImageUrl: String = ""

    constructor(surveyApiModel: SurveyApiModel) : this() {
        this.id = surveyApiModel.id
        this.type = surveyApiModel.type
        this.title = surveyApiModel.title
        this.description = surveyApiModel.description
        this.isActive = surveyApiModel.isActive
        this.coverImageUrl = surveyApiModel.coverImageUrl.string
    }
}
