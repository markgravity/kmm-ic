package co.nimblehq.mark.kmmic.di

import co.nimblehq.mark.kmmic.data.repository.AuthRepositoryImpl
import co.nimblehq.mark.kmmic.data.service.api.ApiService
import co.nimblehq.mark.kmmic.data.service.auth.AuthService
import co.nimblehq.mark.kmmic.data.service.auth.AuthServiceImpl
import co.nimblehq.mark.kmmic.domain.repository.AuthRepository
import co.nimblehq.mark.kmmic.domain.usecase.LoginUseCase
import co.nimblehq.mark.kmmic.domain.usecase.LoginUseCaseImpl
import com.russhwolf.settings.Settings
import org.koin.core.context.startKoin
import org.koin.dsl.module

fun init() {
    val commonModule = module {
        factory { Settings() }
    }

    val serviceModule = module {
        factory { ApiService() }
        factory<AuthService> { AuthServiceImpl() }
        factory<AuthRepository> { AuthRepositoryImpl() }
    }

    val useCaseModule = module {
        factory<LoginUseCase> { LoginUseCaseImpl() }
    }

    startKoin {
        modules(listOf(commonModule, serviceModule, useCaseModule))
    }
}
