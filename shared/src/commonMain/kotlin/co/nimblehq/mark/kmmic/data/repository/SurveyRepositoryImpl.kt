package co.nimblehq.mark.kmmic.data.repository

import co.nimblehq.mark.kmmic.data.service.cached.survey.CachedSurveyService
import co.nimblehq.mark.kmmic.data.service.cached.survey.model.CachedSurvey
import co.nimblehq.mark.kmmic.data.service.cached.survey.model.toSurvey
import co.nimblehq.mark.kmmic.data.service.survey.SurveyService
import co.nimblehq.mark.kmmic.data.service.survey.model.*
import co.nimblehq.mark.kmmic.data.service.survey.model.GetSurveysParams
import co.nimblehq.mark.kmmic.data.service.survey.model.toCachedSurvey
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurvey
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurveyDetail
import co.nimblehq.mark.kmmic.domain.model.Survey
import co.nimblehq.mark.kmmic.domain.model.SurveyDetail
import co.nimblehq.mark.kmmic.domain.model.SurveySubmission
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.last
import kotlinx.coroutines.flow.map
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

private const val FIRST_PAGE_NUMBER = 1

internal class SurveyRepositoryImpl: SurveyRepository, KoinComponent {

    private val surveyService: SurveyService by inject()
    private val cachedSurveyService: CachedSurveyService by inject()

    override fun getSurveys(
        pageNumber: Int,
        pageSize: Int,
        isRefresh: Boolean
    ): Flow<List<Survey>> {
        return flow {
            if (isRefresh) {
                cachedSurveyService.clear()
            }

            if (!isRefresh && pageNumber == FIRST_PAGE_NUMBER) {
                val surveys = cachedSurveyService.get()
                    .map { it.toSurvey() }
                if (surveys.isNotEmpty()) emit(surveys)
            }

            val surveys = surveyService
                .getSurveys(GetSurveysParams(pageNumber, pageSize))
                .last()
            emit(surveys.map { it.toSurvey() })

            cachedSurveyService.save(surveys.map { it.toCachedSurvey() })
        }
    }

    override fun getSurveyDetail(id: String): Flow<SurveyDetail> {
        return surveyService
            .getSurvey(id)
            .map { it.toSurveyDetail() }
    }

    override fun submitSurvey(submission: SurveySubmission): Flow<Unit> {
        return surveyService.submitSurvey(SurveySubmissionParams(submission))
    }
}
