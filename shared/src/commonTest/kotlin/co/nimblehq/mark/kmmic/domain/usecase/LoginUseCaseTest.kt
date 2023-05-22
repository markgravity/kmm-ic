package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.data.service.auth.model.AuthTokenApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurveyDetail
import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import co.nimblehq.mark.kmmic.dummy.dummy
import kotlin.test.BeforeTest
import io.kotest.matchers.shouldBe
import io.mockative.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flowOf
import org.koin.core.context.startKoin
import org.koin.dsl.module
import kotlin.test.Test
import kotlinx.coroutines.test.runTest
import org.koin.core.context.stopKoin
import kotlin.test.AfterTest

@ExperimentalCoroutinesApi
class LoginUseCaseTest {

    private lateinit var loginUseCase: LoginUseCase

    @Mock
    private val mockAuthRepository = mock(classOf<AuthRepository>())
    private val mockToken = AuthToken(
        "accessToken",
        "tokenType",
        1,
        "refreshToken",
        1
    )

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockAuthRepository }
                }
            )
        }

        loginUseCase = LoginUseCaseImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when invoke is called - it returns token correctly`() = runTest {
        given(mockAuthRepository)
            .function(mockAuthRepository::login)
            .whenInvokedWith(any())
            .thenReturn(flowOf(mockToken))

        loginUseCase("abc", "abc").first() shouldBe mockToken
    }
}
