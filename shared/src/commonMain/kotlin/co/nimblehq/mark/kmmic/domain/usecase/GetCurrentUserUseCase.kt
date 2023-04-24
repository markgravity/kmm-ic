package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.domain.model.User
import co.nimblehq.mark.kmmic.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

interface GetCurrentUserUseCase {
    fun invoke(): Flow<User>
}

class GetCurrentUserUseCaseImpl : GetCurrentUserUseCase, KoinComponent {
    private val userRepository: UserRepository by inject()

    override fun invoke(): Flow<User> {
        return userRepository.getProfile()
    }
}
