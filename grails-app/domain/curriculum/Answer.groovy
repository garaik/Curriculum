package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 23/10/13
 * Time: 12:40
 * To change this template use File | Settings | File Templates.
 */
class Answer {
    String answerText
    boolean isCorrect
    String teacherInstruction
    AnswerNextQuestion nextQuestion

    static hasMany = [mediaItems: MediaItem, feedbacks: Feedback]
    static belongsTo = [question: Question]
    static mapping = {
        nextQuestion lazy: false
        nextQuestion cascade: "save-update"
    }
    static constraints = {
        answerText(nullable: false, blank: false)
        isCorrect(nullable: false)
        nextQuestion(nullable: true, blank: true)
        mediaItems(nullable: true)
        feedbacks(nullable: true)
    }


    @Override
    public java.lang.String toString() {
        return answerText
    }
}
