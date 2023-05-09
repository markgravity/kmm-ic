package co.nimblehq.mark.kmmic.domain.model

import co.nimblehq.mark.kmmic.data.service.survey.model.SurveyQuestionApiModel

const val QUESTION_DISPLAY_TYPE_INTRO = "intro"
const val QUESTION_DISPLAY_TYPE_STAR = "star"
const val QUESTION_DISPLAY_TYPE_HEART = "heart"
const val QUESTION_DISPLAY_TYPE_SMILEY = "smiley"
const val QUESTION_DISPLAY_TYPE_CHOICE = "choice"
const val QUESTION_DISPLAY_TYPE_NPS = "nps"
const val QUESTION_DISPLAY_TYPE_TEXTAREA = "textarea"
const val QUESTION_DISPLAY_TYPE_TEXTFIELD = "textfield"
const val QUESTION_DISPLAY_TYPE_DROPDOWN = "dropdown"
const val QUESTION_DISPLAY_TYPE_OUTRO = "outro"

data class SurveyQuestion(
    val id: String,
    val text: String,
    val displayOrder: Int,
    val displayType: String,
    val pick: String,
    val coverImageUrl: String,
    val answers: List<SurveyAnswer>
) {
    val sortedAnswers: List<SurveyAnswer>
        get() = answers.sortedBy { it.displayOrder }
}
