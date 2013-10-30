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

    static hasOne = [nextQuestion: Question, previousAnswer: Answer]

}
