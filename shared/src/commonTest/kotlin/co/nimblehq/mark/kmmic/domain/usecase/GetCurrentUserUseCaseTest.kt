package co.nimblehq.mark.kmmic.domain.usecase

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
class GetCurrentUserUseCaseTest {
    @Mock
    private val mockUserRepository = mock(classOf<UserRepository>())
    private lateinit var useCase: GetCurrentUserUseCase
    private val mockUser = User(
        "dev@nimblehq.co",
        "Nimble Team",
        "https://www.example.com/image.png"
    )

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockUserRepository }
                }
            )
        }

        useCase = GetCurrentUserUseCaseImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when call is called - it returns the correctly user`() = runTest {
        given(mockUserRepository)
            .function(mockUserRepository::getProfile)
            .whenInvoked()
            .thenReturn(
                flow {
                    emit(mockUser)
                }
            )

        useCase().first() shouldBe mockUser
    }

}
