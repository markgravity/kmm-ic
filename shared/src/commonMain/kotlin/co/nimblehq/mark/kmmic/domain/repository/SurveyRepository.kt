package co.nimblehq.mark.kmmic.domain.repository

import co.nimblehq.mark.kmmic.domain.model.Survey
import co.nimblehq.mark.kmmic.domain.model.SurveyDetail
import kotlinx.coroutines.flow.Flow

internal interface SurveyRepository {

    fun getSurveys(
        pageNumber: Int,
        pageSize: Int,
        isRefresh: Boolean
    ): Flow<List<Survey>>

    fun getSurveyDetail(id: String): Flow<SurveyDetail>
}
