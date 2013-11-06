package curriculum

import org.springframework.dao.DataIntegrityViolationException

class GapFillExerciseStringController {

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
