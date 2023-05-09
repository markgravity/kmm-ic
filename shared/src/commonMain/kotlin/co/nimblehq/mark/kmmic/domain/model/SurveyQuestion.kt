package co.nimblehq.mark.kmmic.domain.model

enum class QuestionDisplayType {
    INTRO,
    STAR,
    HEART,
    SMILEY,
    CHOICE,
    NPS,
    TEXTAREA,
    TEXTFIELD,
    DROPDOWN,
    OUTRO
}

data class SurveyQuestion(
    val id: String,
    val text: String,
    val displayOrder: Int,
    val displayType: QuestionDisplayType,
    val pick: String,
    val coverImageUrl: String,
    val answers: List<SurveyAnswer>
) {
    val sortedAnswers: List<SurveyAnswer>
        get() = answers.sortedBy { it.displayOrder }
}
