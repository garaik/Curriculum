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
    AnswerNextQuestion previousAnswer

    static belongsTo = [Exercise]
    static hasMany = [exercises: Exercise, answers: Answer, mediaItems: MediaItem, feedbacks: Feedback]

    static constraints = {
        questionText(nullable: false)
        questionDisplayType(nullable: false)
        previousAnswer(nullable: true, blank: true)
        exercises(nullable: true)
        answers(nullable: true)
        mediaItems(nullable: true)
        feedbacks(nullable: true)
    }
    static mapping = {
        answers cascade: 'delete-orphan'
        feedbacks cascade: 'delete-orphan'
    }


    @Override
    public java.lang.String toString() {
        return questionText
    }
}
