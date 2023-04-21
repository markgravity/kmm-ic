package co.nimblehq.mark.kmmic.data.service.auth

import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.api.extension.path
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthLoginParams
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthTokenApiModel
import co.nimblehq.mark.kmmic.di.UNAUTHORIZED_API_SERVICE_NAME
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.setBody
import io.ktor.http.HttpMethod
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.qualifier.named

internal interface AuthService {
    fun login(params: AuthLoginParams): Flow<AuthTokenApiModel>
}

internal class AuthServiceImpl: AuthService, KoinComponent {
    private val apiService: ApiService by inject(qualifier = named(UNAUTHORIZED_API_SERVICE_NAME))

    override fun login(params: AuthLoginParams): Flow<AuthTokenApiModel> {
        return apiService.performRequest<AuthTokenApiModel>(
            HttpRequestBuilder().apply {
                path("/v1/oauth/token")
                method = HttpMethod.Post
                setBody(params)
            }
        )
    }
}
