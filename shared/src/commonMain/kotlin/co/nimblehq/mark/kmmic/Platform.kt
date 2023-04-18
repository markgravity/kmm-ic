package co.nimblehq.mark.kmmic

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform