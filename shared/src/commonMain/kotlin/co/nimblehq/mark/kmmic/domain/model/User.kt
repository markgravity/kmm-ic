package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.user.model.UserApiModel
import kotlinx.serialization.Serializable

@Serializable
data class User (
    val email: String,
    val name: String,
    val avatarUrl: String
) {

    internal constructor(response: UserApiModel) : this(
        response.email,
        response.name,
        response.avatarUrl
    )
}
