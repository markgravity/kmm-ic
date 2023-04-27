package co.nimblehq.mark.kmmic.data.service.cached.survey

import co.nimblehq.mark.kmmic.data.service.cached.survey.model.CachedSurvey
import io.realm.kotlin.Realm
import io.realm.kotlin.UpdatePolicy
import io.realm.kotlin.ext.query
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal interface CachedSurveyService {

    fun save(surveys: List<CachedSurvey>)
    fun get(): List<CachedSurvey>
    fun clear()
}

internal class CachedSurveyServiceImpl: CachedSurveyService, KoinComponent {

    private val realm: Realm by inject()

    override fun save(surveys: List<CachedSurvey>) {
        realm.writeBlocking {
            surveys.forEach {
                copyToRealm(it, updatePolicy = UpdatePolicy.ALL)
            }
        }
    }

    override fun get(): List<CachedSurvey> {
        return realm.query<CachedSurvey>().find()
    }

    override fun clear() {
        realm.writeBlocking {
            val surveys = query<CachedSurvey>().find()
            delete(surveys)
        }
    }
}
