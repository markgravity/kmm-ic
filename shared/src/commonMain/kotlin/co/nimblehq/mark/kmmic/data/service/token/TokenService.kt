package co.nimblehq.mark.kmmic.data.service.token

import co.nimblehq.mark.kmmic.domain.model.AuthToken
import com.russhwolf.settings.ExperimentalSettingsApi
import com.russhwolf.settings.Settings
import com.russhwolf.settings.serialization.decodeValueOrNull
import com.russhwolf.settings.serialization.encodeValue
import kotlinx.serialization.ExperimentalSerializationApi
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

private const val ACCESS_TOKEN_KEY = "access_token"

internal interface TokenService {
    fun save(token: AuthToken)
    fun get(): AuthToken?
}

@OptIn(ExperimentalSerializationApi::class, ExperimentalSettingsApi::class)
internal class TokenServiceImpl: TokenService, KoinComponent {
    private val settings: Settings by inject()

    override fun save(token: AuthToken) {
        settings.encodeValue(AuthToken.serializer(), ACCESS_TOKEN_KEY, token)
    }

    override fun get(): AuthToken? {
        return settings.decodeValueOrNull(AuthToken.serializer(), ACCESS_TOKEN_KEY)
    }
}
