package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import co.nimblehq.mark.kmmic.domain.model.Survey
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
class GetSurveysUseCaseTest {

    private lateinit var useCase: GetSurveysUseCase

    @Mock
    private val mockSurveyRepository = mock(classOf<SurveyRepository>())
    private val mockSurvey = Survey(SurveyApiModel.dummy)

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockSurveyRepository }
                }
            )
        }

        useCase = GetSurveysUseCaseImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when invoke is called - it returns surveys correctly`() = runTest {
        given(mockSurveyRepository)
            .function(mockSurveyRepository::getSurveys)
            .whenInvokedWith(any())
            .thenReturn(flowOf(listOf(mockSurvey)))

        useCase(1, 1, false).first() shouldBe listOf(mockSurvey)
    }
}
