package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.user.model.UserResponse
import kotlinx.serialization.Serializable

@Serializable
data class User constructor(
    val email: String,
    val name: String,
    val avatarUrl: String
) {

    internal constructor(response: UserResponse) : this(
        response.email,
        response.name,
        response.avatarUrl
    )
}
