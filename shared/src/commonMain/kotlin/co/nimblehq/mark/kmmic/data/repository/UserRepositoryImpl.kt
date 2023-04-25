package co.nimblehq.mark.kmmic.data.repository

import co.nimblehq.mark.kmmic.data.service.user.UserService
import co.nimblehq.mark.kmmic.domain.model.User
import co.nimblehq.mark.kmmic.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

internal class UserRepositoryImpl: UserRepository, KoinComponent {
    private val userService: UserService by inject()

    override fun getProfile(): Flow<User> {
        return userService
            .getProfile()
            .map { User(it) }
    }
}
