package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurveyDetail
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
class GetSurveyUseCaseTest {

    private lateinit var useCase: GetSurveyUseCase

    @Mock
    private val mockSurveyRepository = mock(classOf<SurveyRepository>())
    private val mockSurveyDetail = SurveyDetailApiModel.dummy.toSurveyDetail()

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockSurveyRepository }
                }
            )
        }

        useCase = GetSurveyUseCaseImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when invoke is called - it returns survey correctly`() = runTest {
        given(mockSurveyRepository)
            .function(mockSurveyRepository::getSurvey)
            .whenInvokedWith(any())
            .thenReturn(flowOf(mockSurveyDetail))

        useCase("abc").first() shouldBe mockSurveyDetail
    }
}
