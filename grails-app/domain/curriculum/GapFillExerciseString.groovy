package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 25/10/13
 * Time: 18:24
 * To change this template use File | Settings | File Templates.
 */
class GapFillExerciseString {

    Integer startPosition
    Integer endPosition
    String hiddenString

    List gapFillExerciseAlternatives

    static hasMany = [gapFillExerciseAlternatives: GapFillExerciseAlternative]
    static belongsTo = [gapFillExercise: GapFillExercise]
    static mapping = {
        gapFillExerciseAlternatives cascade: 'all-delete-orphan'
    }


}
