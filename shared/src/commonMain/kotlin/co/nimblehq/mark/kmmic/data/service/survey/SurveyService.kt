package co.nimblehq.mark.kmmic.data.service.survey

import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.api.extension.path
import co.nimblehq.mark.kmmic.data.service.api.extension.setQueryParameters
import co.nimblehq.mark.kmmic.data.service.survey.model.GetSurveysParams
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveySubmissionParams
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.http.HttpMethod
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import io.ktor.client.request.setBody

internal interface SurveyService {

    fun getSurveys(params: GetSurveysParams): Flow<List<SurveyApiModel>>
    fun getSurvey(id: String): Flow<SurveyDetailApiModel>
    fun submitSurvey(body: SurveySubmissionParams): Flow<Unit>
}

internal class SurveyServiceImpl: SurveyService, KoinComponent {

    private val apiService: ApiService by inject()

    override fun getSurveys(params: GetSurveysParams): Flow<List<SurveyApiModel>> {
        return apiService.performRequest<List<SurveyApiModel>>(
            HttpRequestBuilder().apply {
                path("/v1/surveys")
                method = HttpMethod.Get
                setQueryParameters(params)
            }
        )
    }

    override fun getSurvey(id: String): Flow<SurveyDetailApiModel> {
        return apiService.performRequest(
            HttpRequestBuilder().apply {
                path("/v1/surveys/${id}")
                method = HttpMethod.Get
            }
        )
    }

    override fun submitSurvey(body: SurveySubmissionParams): Flow<Unit> {
        return apiService.performRequestWithEmptyResponse(
            HttpRequestBuilder().apply {
                path("/v1/responses")
                method = HttpMethod.Post
                setBody(body)
            }
        )
    }
}
