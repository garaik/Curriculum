package curriculum


class GapFillExerciseAlternative {

    String alternative

   static belongsTo = [GapFillExerciseString]

    static constraints = {
        alternative(nullable: true, blank: true)
    }
}
