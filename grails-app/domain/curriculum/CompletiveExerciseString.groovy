package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 25/10/13
 * Time: 18:24
 * To change this template use File | Settings | File Templates.
 */
class CompletiveExerciseString {

    static hasMany = [completiveAlternative: CompletiveAlternative]
    static belongsTo = [completiveExercise: CompletiveExercise]
    Integer startPosition
    Integer endPosition
    String hiddenString
    String answerString
}
