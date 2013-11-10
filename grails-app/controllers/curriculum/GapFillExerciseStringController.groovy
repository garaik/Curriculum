package curriculum

class GapFillExerciseStringController {

    def beforeInterceptor = [action: this.&auth]

    def auth() {
        if (!session.user) {
            redirect(controller: "user", action: "login")
            return false
        }
    }

    /**
     * Add GapFillExerciseAlternatives to GapFillExerciseString instance
     * @return renders the gap_fill_exercise_string_alternatives with new GapFillExerciseAlternative
     */
    def addGapFillExerciseStringAlternative() {
        def exercise
            exercise = new GapFillExercise(params)

        List gapStringList = exercise.gapFillExerciseStrings?.toArray()
        GapFillExerciseString gapFillExerciseStringInstance = gapStringList.get(Integer.parseInt(params?.gapStringIndex))
        GapFillExerciseAlternative alternative = new GapFillExerciseAlternative()
        if(gapFillExerciseStringInstance.gapFillExerciseAlternatives == null){
            gapFillExerciseStringInstance.gapFillExerciseAlternatives = []
        }
        if (gapFillExerciseStringInstance.id != null){
                      alternative.save(flush: true)
        }
        gapFillExerciseStringInstance.gapFillExerciseAlternatives << alternative

        render template: "/gapFillExercise/gap_fill_exercise_string_list", model: [instance: exercise]
    }

    /**
     * Remove GapFillExerciseAlternative from GapFillExerciseString instance
     * @return renders the gap_fill_exercise_string_alternatives without the removed GapFillExerciseAlternative
     */
    def removeGapFillExerciseStringAlternative() {
        def exercise
            exercise = new GapFillExercise(params)

        List gapStringList = exercise.gapFillExerciseStrings.toArray()
        GapFillExerciseString gapFillExerciseStringInstance = gapStringList.get(Integer.parseInt(params?.gapStringIndex))
        List gapFillExerciseAlternativesList = gapFillExerciseStringInstance.gapFillExerciseAlternatives.toArray()
        def gapFillExerciseAlternative = gapFillExerciseAlternativesList.get(Integer.parseInt(params.alternativeRemoveIx))
        gapFillExerciseStringInstance.gapFillExerciseAlternatives.remove(gapFillExerciseAlternative)
        render template: "/gapFillExercise/gap_fill_exercise_string_list", model: [instance: exercise]
    }

}
