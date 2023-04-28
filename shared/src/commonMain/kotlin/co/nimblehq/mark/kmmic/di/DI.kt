package co.nimblehq.mark.kmmic.di

import co.nimblehq.mark.kmmic.data.repository.AuthRepositoryImpl
import co.nimblehq.mark.kmmic.data.repository.SurveyRepositoryImpl
import co.nimblehq.mark.kmmic.data.repository.UserRepositoryImpl
import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.auth.AuthService
import co.nimblehq.mark.kmmic.data.service.auth.AuthServiceImpl
import co.nimblehq.mark.kmmic.data.service.cached.survey.CachedSurveyService
import co.nimblehq.mark.kmmic.data.service.cached.survey.CachedSurveyServiceImpl
import co.nimblehq.mark.kmmic.data.service.cached.survey.model.CachedSurvey
import co.nimblehq.mark.kmmic.data.service.survey.SurveyService
import co.nimblehq.mark.kmmic.data.service.survey.SurveyServiceImpl
import co.nimblehq.mark.kmmic.data.service.token.TokenService
import co.nimblehq.mark.kmmic.data.service.token.TokenServiceImpl
import co.nimblehq.mark.kmmic.data.service.user.UserService
import co.nimblehq.mark.kmmic.data.service.user.UserServiceImpl
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import co.nimblehq.mark.kmmic.domain.repository.SurveyRepository
import co.nimblehq.mark.kmmic.domain.repository.UserRepository
import co.nimblehq.mark.kmmic.domain.usecase.GetCurrentUserUseCase
import co.nimblehq.mark.kmmic.domain.usecase.GetCurrentUserUseCaseImpl
import co.nimblehq.mark.kmmic.domain.usecase.LoginUseCase
import co.nimblehq.mark.kmmic.domain.usecase.LoginUseCaseImpl
import com.russhwolf.settings.Settings
import io.realm.kotlin.Realm
import io.realm.kotlin.RealmConfiguration
import org.koin.core.context.startKoin
import org.koin.core.qualifier.named
import org.koin.dsl.module

const val UNAUTHORIZED_API_SERVICE_NAME = "UNAUTHORIZED_API_CLIENT"

fun init() {
    val commonModule = module {
        single { Settings() }
        single {
            val configuration = RealmConfiguration.create(schema = setOf(CachedSurvey::class))
            Realm.open(configuration)
        }
    }

    val dataModule = module {
        factory { ApiService(requiresAuthentication = true) }
        factory(named(UNAUTHORIZED_API_SERVICE_NAME)) { ApiService(requiresAuthentication = false) }
        factory<TokenService> { TokenServiceImpl() }
        factory<AuthService> { AuthServiceImpl() }
        factory<AuthRepository> { AuthRepositoryImpl() }
        factory<UserService> { UserServiceImpl() }
        factory<UserRepository> { UserRepositoryImpl() }
        factory<SurveyService> { SurveyServiceImpl() }
        factory<CachedSurveyService> { CachedSurveyServiceImpl() }
        factory<SurveyRepository> { SurveyRepositoryImpl() }
    }

    val domainModule = module {
        factory<LoginUseCase> { LoginUseCaseImpl() }
        factory<GetCurrentUserUseCase> { GetCurrentUserUseCaseImpl() }
    }

    startKoin {
        modules(commonModule + dataModule + domainModule)
    }
}
