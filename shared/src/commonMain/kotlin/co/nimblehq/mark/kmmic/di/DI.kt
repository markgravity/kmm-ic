package co.nimblehq.mark.kmmic.di

import org.koin.core.context.startKoin

fun init() {
    startKoin {
        modules()
    }
}
