package co.nimblehq.mark.kmmic.data.service.api

import co.nimblehq.jsonapi.json.JsonApi
import co.nimblehq.jsonapi.model.JsonApiException
import co.nimblehq.mark.kmmic.data.service.token.TokenService
import io.github.aakira.napier.DebugAntilog
import io.github.aakira.napier.Napier
import io.ktor.client.HttpClient
import io.ktor.client.plugins.auth.*
import io.ktor.client.plugins.auth.providers.*
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.ContentType
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.*
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal class ApiService(requiresAuthentication: Boolean = false): KoinComponent {
    private val tokenService: TokenService by inject()

    val httpClient: HttpClient
    val jsonConfigs = Json {
        prettyPrint = true
        isLenient = true
        encodeDefaults = true
        ignoreUnknownKeys = true
    }

    init {
        Napier.takeLogarithm()
        Napier.base(DebugAntilog())

        httpClient = HttpClient {
            install(Logging) {
                level = LogLevel.ALL
                logger = object : Logger {
                    override fun log(message: String) {
                        Napier.log(io.github.aakira.napier.LogLevel.DEBUG, message = message)
                    }
                }
            }

            install(ContentNegotiation) {
                json(jsonConfigs)
            }

            if (requiresAuthentication) {
                install(Auth) {
                    bearer {
                        loadTokens {
                            tokenService.get()?.run {
                                BearerTokens(accessToken, refreshToken)
                            }
                        }
                    }
                }
            }
        }
    }
    inline fun <reified T> performRequest(builder: HttpRequestBuilder): Flow<T> {
        return flow {
            val body = httpClient.request(
                builder.apply {
                    contentType(ContentType.Application.Json)
                }
            ).bodyAsText()
            try {
                val data = JsonApi(jsonConfigs).decodeFromJsonApiString<T>(body)
                emit(data)
            } catch (e: JsonApiException) {
                val message = e.errors.first().detail
                throw ApiError(message)
            }
        }
    }

    fun performRequestWithEmptyResponse(builder: HttpRequestBuilder): Flow<Unit> {
        return flow {
            val body = httpClient.request(
                builder.apply {
                    contentType(ContentType.Application.Json)
                }
            ).bodyAsText()
            try {
                if (body != "{}") JsonApi(jsonConfigs).decodeFromJsonApiString<Unit>(body)
                emit(Unit)
            } catch (e: JsonApiException) {
                val message = e.errors.first().detail
                throw ApiError(message)
            }
        }
    }
}
