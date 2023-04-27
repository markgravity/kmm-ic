package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.domain.model.Survey
import co.nimblehq.mark.kmmic.domain.model.SurveyDetail
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

interface GetSurveyUseCase {

    operator fun invoke(id: String): Flow<SurveyDetail>
}

class GetSurveyUseCaseImpl : GetSurveyUseCase, KoinComponent {

    private val surveyRepository: SurveyRepository by inject()

    override fun invoke(id: String): Flow<SurveyDetail> {
        return surveyRepository
            .getSurvey(id)
    }
}
