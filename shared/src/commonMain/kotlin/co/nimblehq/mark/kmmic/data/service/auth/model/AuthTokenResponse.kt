package co.nimblehq.mark.kmmic.data.service.auth.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
internal data class AuthTokenResponse(
    @SerialName("id")
    val id: String,
    @SerialName("type")
    val type: String,
    @SerialName("access_token")
    val accessToken: String,
    @SerialName("token_type")
    val tokenType: String,
    @SerialName("expires_in")
    val expiresIn: Int,
    @SerialName("refresh_token")
    val refreshToken: String,
    @SerialName("created_at")
    val createdAt: Int
)
