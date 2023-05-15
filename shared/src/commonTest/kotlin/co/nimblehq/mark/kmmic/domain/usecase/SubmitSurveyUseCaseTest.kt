package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyDetailApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurveyDetail
import co.nimblehq.mark.kmmic.domain.model.SurveySubmission
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import co.nimblehq.mark.kmmic.dummy.dummy
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
class SubmitSurveyUseCaseTest {

    private lateinit var submitSurveyUseCase: SubmitSurveyUseCase

    @Mock
    private val mockSurveyRepository = mock(classOf<SurveyRepository>())
    private val surveySubmission = SurveySubmission(
        "id",
        emptyList()
    )

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockSurveyRepository }
                }
            )
        }

        submitSurveyUseCase = SubmitSurveyUseCaseImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when invoke is called - it returns empty response`() = runTest {
        given(mockSurveyRepository)
            .function(mockSurveyRepository::submitSurvey)
            .whenInvokedWith(any())
            .thenReturn(flow { emit(Unit) })

        submitSurveyUseCase(surveySubmission).first() shouldBe Unit
    }
}
