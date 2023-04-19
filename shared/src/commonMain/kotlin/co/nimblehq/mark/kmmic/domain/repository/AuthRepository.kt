package co.nimblehq.mark.kmmic.domain.repository

import co.nimblehq.mark.kmmic.domain.model.AuthToken
import kotlinx.coroutines.flow.Flow

internal interface AuthRepository {
    fun login(email: String,  password: String): Flow<AuthToken>
    fun saveToken(token: AuthToken)
    fun getToken(): AuthToken?
}
