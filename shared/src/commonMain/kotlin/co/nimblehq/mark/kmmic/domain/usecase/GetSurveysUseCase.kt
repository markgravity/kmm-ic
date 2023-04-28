package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.model.Survey
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.onEach
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

interface GetSurveysUseCase {

    operator fun invoke(pageNumber: Int, pageSize: Int, isRefresh: Boolean): Flow<List<Survey>>
}

class GetSurveysUseCaseImpl : GetSurveysUseCase, KoinComponent {

    private val surveyRepository: SurveyRepository by inject()

    override fun invoke(pageNumber: Int, pageSize: Int, isRefresh: Boolean): Flow<List<Survey>> {
        return surveyRepository
            .getSurveys(pageNumber, pageSize, isRefresh)
    }
}
