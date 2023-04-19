package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.onEach
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

interface LoginUseCase {
    fun call(email: String, password: String): Flow<AuthToken>
}

class LoginUseCaseImpl : LoginUseCase, KoinComponent {
    private val authRepository: AuthRepository by inject()

    override fun call(email: String, password: String): Flow<AuthToken> {
        return authRepository
            .login(email, password)
            .onEach { authRepository.saveToken(it) }
    }
}
