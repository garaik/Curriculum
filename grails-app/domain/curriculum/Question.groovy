package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 20/10/13
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
class Question {

    String questionText
    QuestionDisplayType questionDisplayType
    MultipleChoiceExercise exercise
    List feedbacks

    static belongsTo = [exercise: MultipleChoiceExercise]
    static hasMany = [answers: Answer, mediaItems: MediaItem, feedbacks: Feedback, previousAnswers: AnswerNextQuestion]

    static constraints = {
        questionText(nullable: false, blank: false)
        questionDisplayType(nullable: false, blank: false)
        previousAnswers(nullable: true)
        answers(nullable: true)
        mediaItems(nullable: true)
        feedbacks(nullable: true)
    }
    static mapping = {
        answers cascade: 'delete-orphan'
        feedbacks cascade: 'delete-orphan'
        exercise cascade: 'save-update'
        exercise lazy: false
    }

    @Override
    public java.lang.String toString() {
        return questionText
    }
}
