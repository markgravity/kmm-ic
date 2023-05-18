package co.nimblehq.mark.kmmic.data.repository

import app.cash.turbine.test
import co.nimblehq.mark.kmmic.data.service.auth.AuthService
import co.nimblehq.mark.kmmic.data.service.auth.model.AuthTokenApiModel
import co.nimblehq.mark.kmmic.data.service.token.TokenService
import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import kotlin.test.BeforeTest
import io.kotest.matchers.shouldBe
import io.mockative.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOf
import org.koin.core.context.startKoin
import org.koin.dsl.module
import kotlin.test.Test
import kotlinx.coroutines.test.runTest
import org.koin.core.context.stopKoin
import kotlin.test.AfterTest

@ExperimentalCoroutinesApi
class AuthRepositoryTest {
    @Mock
    private val mockAuthService = mock(classOf<AuthService>())
    @Mock
    private val mockTokenService = mock(classOf<TokenService>())
    private lateinit var authRepository: AuthRepository
    private val mockTokenApi = AuthTokenApiModel(
        "id",
        "type",
        "accessToken",
        "tokenType",
        1,
        "refreshToken",
        1
    )
    private val mockToken = AuthToken(mockTokenApi)
    private val mockThrowable = Throwable("mock")

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockAuthService }
                    single { mockTokenService }
                }
            )
        }

        authRepository = AuthRepositoryImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when login is called - it returns the correctly token`() = runTest {
        given(mockAuthService)
            .function(mockAuthService::login)
            .whenInvokedWith(any())
            .thenReturn(flowOf(mockTokenApi))

        authRepository.login("email", "password").first() shouldBe mockToken
    }

    @Test
    fun `when login is failed - it emits error`() = runTest {
        given(mockAuthService)
            .function(mockAuthService::login)
            .whenInvokedWith(any())
            .thenReturn(
                flow {
                    throw mockThrowable
                }
            )

        authRepository.login("email", "password").test {
            this.awaitError().message shouldBe mockThrowable.message
        }
    }

    @Test
    fun `when saveToken is called - it triggers tokenService to save`() = runTest {
        authRepository.saveToken(mockToken)

        verify(mockTokenService)
            .function(mockTokenService::save)
            .with(any())
            .wasInvoked(exactly = 1.times)
    }

    @Test
    fun `when getToken is called - it returns the correctly token`() = runTest {
        given(mockTokenService)
            .function(mockTokenService::get)
            .whenInvoked()
            .thenReturn(mockToken)

        authRepository.getToken() shouldBe mockToken
    }
}
