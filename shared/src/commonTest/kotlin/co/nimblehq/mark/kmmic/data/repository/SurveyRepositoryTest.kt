package co.nimblehq.mark.kmmic.data.repository

import app.cash.turbine.test
import co.nimblehq.mark.kmmic.data.service.cached.survey.CachedSurveyService
import co.nimblehq.mark.kmmic.data.service.cached.survey.model.CachedSurvey
import co.nimblehq.mark.kmmic.data.service.survey.SurveyService
import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyApiModel
import co.nimblehq.mark.kmmic.data.service.survey.model.toCachedSurvey
import co.nimblehq.mark.kmmic.data.service.survey.model.toSurvey
import co.nimblehq.mark.kmmic.domain.model.Survey
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import co.nimblehq.mark.kmmic.dummy.dummy
import kotlin.test.BeforeTest
import io.kotest.matchers.shouldBe
import io.mockative.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOf
import org.koin.core.context.startKoin
import org.koin.dsl.module
import kotlin.test.Test
import kotlinx.coroutines.test.runTest
import org.koin.core.context.stopKoin
import kotlin.test.AfterTest

@ExperimentalCoroutinesApi
class SurveyRepositoryTest {

    private lateinit var repository: SurveyRepository

    @Mock
    private val mockSurveyService = mock(classOf<SurveyService>())
    @Mock
    private val mockCachedSurveyService = mock(classOf<CachedSurveyService>())
    private val mockThrowable = Throwable("mock")
    private val mockSurveyApiModel = SurveyApiModel.dummy
    private val mockCachedSurvey = mockSurveyApiModel.toCachedSurvey()
    private val mockSurvey = mockSurveyApiModel.toSurvey()

    @BeforeTest
    fun setUp() {
        startKoin{
            modules(
                module {
                    single { mockSurveyService }
                    single { mockCachedSurveyService }
                }
            )
        }

        repository = SurveyRepositoryImpl()
    }

    @AfterTest
    fun tearDown() {
        stopKoin()
    }

    @Test
    fun `when there is no cached survey and get surveys is succeeded - it emits surveys once`() = runTest {
        given(mockSurveyService)
            .function(mockSurveyService::getSurveys)
            .whenInvokedWith(any())
            .thenReturn(flowOf(listOf(mockSurveyApiModel)))
        given(mockCachedSurveyService)
            .function(mockCachedSurveyService::get)
            .whenInvoked()
            .thenReturn(listOf())

        repository.getSurveys(1, 1, false).test {
            this.awaitItem() shouldBe listOf(mockSurvey)
            this.awaitComplete()
        }
    }

    @Test
    fun `when there is cached survey and get surveys is succeeded - it emits surveys twice`() = runTest {
        given(mockSurveyService)
            .function(mockSurveyService::getSurveys)
            .whenInvokedWith(any())
            .thenReturn(flowOf(listOf(mockSurveyApiModel)))
        given(mockCachedSurveyService)
            .function(mockCachedSurveyService::get)
            .whenInvoked()
            .thenReturn(listOf(mockCachedSurvey))

        repository.getSurveys(1, 1, false).test {
            this.awaitItem() shouldBe listOf(mockSurvey)
            this.awaitItem() shouldBe listOf(mockSurvey)
            this.awaitComplete()
        }
    }

    @Test
    fun `when refreshing and get surveys is succeeded - it emits surveys once from API`() = runTest {
        given(mockSurveyService)
            .function(mockSurveyService::getSurveys)
            .whenInvokedWith(any())
            .thenReturn(flowOf(listOf(mockSurveyApiModel)))

        repository.getSurveys(1, 1, true).test {
            this.awaitItem() shouldBe listOf(mockSurvey)
            this.awaitComplete()
        }

        verify(mockCachedSurveyService)
            .function(mockCachedSurveyService::clear)
            .wasInvoked(exactly = 1.times)
    }

    @Test
    fun `when get surveys is failed - it emits error`() = runTest {
        given(mockSurveyService)
            .function(mockSurveyService::getSurveys)
            .whenInvokedWith(any())
            .thenReturn(
                flow {
                    throw mockThrowable
                }
            )

        repository.getSurveys(1, 1, true).test {
            this.awaitError().message shouldBe mockThrowable.message
        }
    }
}