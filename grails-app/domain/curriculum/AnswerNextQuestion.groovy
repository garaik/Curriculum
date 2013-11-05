package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 26/10/13
 * Time: 15:50
 * To change this template use File | Settings | File Templates.
 */
class AnswerNextQuestion {

    Exercise exercise
    Question nextQuestion

    static belongsTo = [nextQuestion: Question, previousAnswer: Answer]
    static mapping = {
        nextQuestion lazy: false
        nextQuestion cascade: "save-update"
    }

    @Override
    public java.lang.String toString() {
        return nextQuestion
    }
}
