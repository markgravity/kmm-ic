package co.nimblehq.mark.kmmic.data.service.auth

import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.api.extension.path
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthLoginParams
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthTokenResponse
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.setBody
import io.ktor.http.HttpMethod
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal interface AuthService {
    fun login(params: AuthLoginParams): Flow<AuthTokenResponse>
}

internal class AuthServiceImpl: AuthService, KoinComponent {
    private val apiService: ApiService by inject()

    override fun login(params: AuthLoginParams): Flow<AuthTokenResponse> {
        return apiService.performRequest<AuthTokenResponse>(
            HttpRequestBuilder().apply {
                path("/v1/oauth/token")
                method = HttpMethod.Post
                setBody(params)
            }
        )
    }
}
