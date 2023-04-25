package co.nimblehq.mark.kmmic.data.repository

import co.nimblehq.mark.kmmic.data.service.auth.AuthService
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthLoginParams
import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import com.russhwolf.settings.ExperimentalSettingsApi
import com.russhwolf.settings.Settings
import com.russhwolf.settings.serialization.decodeValueOrNull
import com.russhwolf.settings.serialization.encodeValue
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlinx.serialization.ExperimentalSerializationApi
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

private const val KEY_ACCESS_TOKEN = "access_token"

@OptIn(ExperimentalSerializationApi::class, ExperimentalSettingsApi::class)
internal class AuthRepositoryImpl: AuthRepository, KoinComponent {
    private val authService: AuthService by inject()
    private val settings: Settings by inject()

    override fun login(email: String, password: String): Flow<AuthToken> {
        return authService
            .login(AuthLoginParams(email = email, password = password))
            .map { AuthToken(it) }
    }

    override fun saveToken(token: AuthToken) {
        settings.encodeValue(AuthToken.serializer(), KEY_ACCESS_TOKEN, token)
    }

    override fun getToken(): AuthToken? {
        return settings.decodeValueOrNull(AuthToken.serializer(), KEY_ACCESS_TOKEN)
    }
}
