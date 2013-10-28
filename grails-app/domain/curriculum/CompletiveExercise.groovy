package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 23/10/13
 * Time: 15:09
 * To change this template use File | Settings | File Templates.
 */
class CompletiveExercise {
    String text
    Exercise exercise
    boolean selectMode
    Feedback feedback

    static hasMany = [completiveExerciseStrings: CompletiveExerciseString]
}
