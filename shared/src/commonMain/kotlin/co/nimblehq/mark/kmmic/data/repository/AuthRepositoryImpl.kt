package co.nimblehq.mark.kmmic.data.repository

import co.nimblehq.mark.kmmic.data.service.auth.AuthService
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthLoginParams
import co.nimblehq.mark.kmmic.data.service.token.TokenService
import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal class AuthRepositoryImpl: AuthRepository, KoinComponent {
    private val authService: AuthService by inject()
    private val tokenService: TokenService by inject()

    override fun login(email: String, password: String): Flow<AuthToken> {
        return authService
            .login(AuthLoginParams(email = email, password = password))
            .map { AuthToken(it) }
    }

    override fun saveToken(token: AuthToken) {
        tokenService.save(token)
    }

    override fun getToken(): AuthToken? {
        return tokenService.get()
    }
}
