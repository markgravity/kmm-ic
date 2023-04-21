package co.nimblehq.mark.kmmic.data.repository

import co.nimblehq.mark.kmmic.data.service.user.UserService
import co.nimblehq.mark.kmmic.data.service.user.model.UserResponse
import co.nimblehq.mark.kmmic.domain.model.User
import co.nimblehq.mark.kmmic.domain.repository.UserRepository
import kotlin.test.BeforeTest
import io.kotest.matchers.shouldBe
import io.mockative.Mock
import io.mockative.classOf
import io.mockative.given
import io.mockative.mock
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flow
import org.koin.core.context.startKoin
import org.koin.dsl.module
import kotlin.test.Test
import kotlinx.coroutines.test.runTest
import org.koin.core.context.stopKoin
import kotlin.test.AfterTest

@ExperimentalCoroutinesApi
class UserRepositoryTest {
    @Mock
    private val mockUserService = mock(classOf<UserService>())
    private lateinit var repository: UserRepository
    private val mockUser = UserResponse(
        "id",
        "type",
        "dev@nimblehq.co",
        "Nimble Team",
        "https://www.example.com/image.png"
    )

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockUserService }
                }
            )
        }

        repository = UserRepositoryImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when me is called - it returns the correctly user`() = runTest {
        given(mockUserService)
            .function(mockUserService::me)
            .whenInvoked()
            .thenReturn(
                flow {
                    emit(mockUser)
                }
            )

        repository.me().collect {
            it shouldBe User(mockUser)
        }
    }

}
