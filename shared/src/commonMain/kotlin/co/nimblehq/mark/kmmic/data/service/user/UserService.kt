package co.nimblehq.mark.kmmic.data.service.user

import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.api.extension.path
import co.nimblehq.mark.kmmic.data.service.user.model.UserResponse
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.http.HttpMethod
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal interface UserService {
    fun me(): Flow<UserResponse>
}

internal class UserServiceImpl: UserService, KoinComponent {
    private val apiService: ApiService by inject()

    override fun me(): Flow<UserResponse> {
        return apiService.performRequest<UserResponse>(
            HttpRequestBuilder().apply {
                path("/v1/me")
                method = HttpMethod.Get
            }
        )
    }
}
