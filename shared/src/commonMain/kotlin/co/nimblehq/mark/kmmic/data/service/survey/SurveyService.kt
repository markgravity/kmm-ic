package co.nimblehq.mark.kmmic.data.service.survey

import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.api.extension.path
import co.nimblehq.mark.kmmic.data.service.api.extension.setQueryParameters
import co.nimblehq.mark.kmmic.data.service.survey.model.GetSurveysParams
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.http.HttpMethod
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal interface SurveyService {

    fun getSurveys(params: GetSurveysParams): Flow<List<SurveyApiModel>>
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
}
