package co.nimblehq.mark.kmmic.domain.repository

import co.nimblehq.mark.kmmic.domain.model.User
import kotlinx.coroutines.flow.Flow

internal interface UserRepository {
    fun getProfile(): Flow<User>
}
