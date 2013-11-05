package curriculum

class GapFillExercise extends Exercise{

    String text
    boolean selectMode
    List gapFillExerciseStrings

    static hasMany = [gapFillExerciseStrings: GapFillExerciseString]

    static constraints = {
        text (maxSize: 65535, blank: false)
    }
    static mapping = {
        gapFillExerciseStrings cascade:'all-delete-orphan'
   	}
}
