package co.nimblehq.mark.kmmic.domain.usecase

import co.nimblehq.mark.kmmic.domain.model.AuthToken
import co.nimblehq.mark.kmmic.domain.model.SurveySubmission
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import kotlinx.coroutines.flow.Flow
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

interface SubmitSurveyUseCase {
    operator fun invoke(submission: SurveySubmission): Flow<Unit>
}

class SubmitSurveyUseCaseImpl : SubmitSurveyUseCase, KoinComponent {
    private val surveyRepository: SurveyRepository by inject()

    override fun invoke(submission: SurveySubmission): Flow<Unit> {
        return surveyRepository
            .submitSurvey(submission)
    }
}
