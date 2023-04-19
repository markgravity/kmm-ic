package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.auth.model.AuthTokenResponse
import kotlinx.serialization.Serializable

@Serializable
data class AuthToken constructor(
    val accessToken: String,
    val tokenType: String,
    val expiresIn: Int,
    val refreshToken: String,
    val createdAt: Int
) {

    internal constructor(response: AuthTokenResponse) : this(
        response.accessToken,
        response.tokenType,
        response.expiresIn,
        response.refreshToken,
        response.createdAt
    )
}
