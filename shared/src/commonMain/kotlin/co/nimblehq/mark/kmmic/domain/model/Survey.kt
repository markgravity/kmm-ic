package co.nimblehq.mark.kmmic.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Survey(
    val id: String,
    val title: String,
    val description: String,
    val isActive: Boolean,
    val coverImageUrl: String
)
