package co.nimblehq.mark.kmmic.data.services

import io.ktor.client.HttpClient
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.ContentType
import io.ktor.http.contentType
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class ApiService(val httpClient: HttpClient) {

    inline fun <reified T> performRequest(builder: HttpRequestBuilder): Flow<T> {
        return flow {
            val body = httpClient.request(
                builder.apply {
                    contentType(ContentType.Application.Json)
                }
            ).bodyAsText()
            try {
                val data = JsonApi(json).decodeFromJsonApiString<T>(body)
                emit(data)
            } catch (e: JsonApiException) {
                val message = e.errors.first().detail
                throw AppError(message)
            }
        }
    }
}
