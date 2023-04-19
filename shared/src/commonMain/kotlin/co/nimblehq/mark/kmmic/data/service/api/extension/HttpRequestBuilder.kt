package co.nimblehq.mark.kmmic.data.service.api.extension

import co.nimblehq.mark.kmmic.BuildKonfig
import co.nimblehq.mark.kmmic.data.service.api.ApiError
import io.ktor.client.request.*
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.json.jsonObject

fun HttpRequestBuilder.path(path: String) {
    url(BuildKonfig.BASE_URL.plus(path))
}

inline fun <reified T> HttpRequestBuilder.setQueryParameters(parameters: T) {
    try {
        val queryParameters = Json.encodeToJsonElement(parameters).jsonObject
        for ((key, value) in queryParameters) {
            parameter(key, value)
        }
    } catch (e: SerializationException) {
        throw ApiError(e.message)
    }
}
