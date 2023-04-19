package co.nimblehq.mark.kmmic.di

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
