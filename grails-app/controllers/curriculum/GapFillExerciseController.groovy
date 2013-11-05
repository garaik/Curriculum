package curriculum

class GapFillExerciseController extends ExerciseController {
    static allowedMethods = [update: "POST",]

    def index() {
        redirect(action: "list", params: params)
    }

    def edit(Long id) {
        GapFillExercise instance = lookUpExercise(id)
        render(view: "/gapFillExercise/edit", model:  [instance: instance, editOrCreate: "edit", isSavedText: "true"])
    }

    def list(Integer max) {
        def pagination = new Pagination(params)
        println(pagination)
        params.max = Math.min(max ?: 10, 100)
        def listParams = pagination.listParams
        println(listParams)
        def result = [:]
        if (pagination.filter) {
            def hits = GapFillExercise.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = GapFillExercise.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    @Override
    def update() {
        GapFillExercise exerciseSavedInstance = lookUpExercise(params.id.toLong())
        if (exerciseSavedInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (exerciseSavedInstance.version > version) {
                    flash.message = message(code: 'Exercise.optimistic.locking.failure', args: [exerciseSavedInstance.id])
                    flash.error = true
                    render(view: "edit", model: [instance: exerciseSavedInstance, editOrCreate: "edit", isSavedText: params.isSavedText])
                    return
                }
            }

            //Remove the unused grade details
            def removeList = OneToManyUtils.elementsToRemoveFromList(params, "gradeDetails", new GradeDetails(), exerciseSavedInstance.gradeDetails)
            exerciseSavedInstance.gradeDetails.removeAll(removeList)

            def removeGapFillStringList = OneToManyUtils.elementsToRemoveFromList(params, "gapFillExerciseStrings", new GapFillExerciseString(), exerciseSavedInstance.gapFillExerciseStrings)
            exerciseSavedInstance.gapFillExerciseStrings.removeAll(removeGapFillStringList)

            exerciseSavedInstance.properties = params

            deleteUnusedSubactivities(exerciseSavedInstance)


            if (!exerciseSavedInstance.save(flush: true)) {
                render(view: "edit", model: [instance: exerciseSavedInstance, editOrCreate: "edit", isSavedText: params.isSavedText])
                return
            }
            flash.message = message(code: 'Exercise.updated.message', args: [exerciseSavedInstance.id])
            redirect(action: "list")
        }
    }

    def create() {
        params.gradeDetails = [new GradeDetails()]
        [instance: new GapFillExercise(params), editOrCreate: "create", isSavedText: "false"]
    }

    def save() {
        def i = new GapFillExercise(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i, editOrCreate: "edit", isSavedText: params.isSavedText])
            return
        }
        flash.message = message(code: 'GapFillExercise.created.message', args: [i.id])
        redirect(action: "list")
    }

    /**
     * Add GapFillExerciseString to GapFillExercise instance
     * @return renders the gap_fill_exercise_strings_form with new GapFillExerciseString
     */
    def addGapFillExerciseString() {
        // add one address to the list of addresses
        def exerciseInstance
            exerciseInstance = new GapFillExercise(params)

        if (params.positionStartValue != null && !"".equals(params.positionTextValue)) {
            def gapFillExerciseStringInstance = new GapFillExerciseString()
            gapFillExerciseStringInstance.setStartPosition(params.positionStartValue.toInteger())
            gapFillExerciseStringInstance.setEndPosition(params.positionEndValue.toInteger())
            gapFillExerciseStringInstance.setHiddenString(params.positionTextValue)

            if(!exerciseInstance.gapFillExerciseStrings){
                exerciseInstance.gapFillExerciseStrings = []
            }

            exerciseInstance.gapFillExerciseStrings << gapFillExerciseStringInstance
        }
        render template: "gap_fill_exercise_string_list", model: [instance: exerciseInstance, editOrCreate: "edit", isSavedText:  params.isSavedText]
    }

    /**
     * Remove GapFillExerciseString from GapFillExercise instance
     * @return renders the gap_fill_exercise_strings_form without the removed GapFillExerciseString
     */
    def removeGapFillExerciseString() {
        // remove selected address from the list of addresses
        def exerciseInstance
            exerciseInstance = new GapFillExercise(params)

        def removeIx = params.removeIx
        List gapFillExerciseStringsList = exerciseInstance.gapFillExerciseStrings.toArray()
        Long removeILong = Long.valueOf(removeIx)
        def gapFillExerciseString = gapFillExerciseStringsList.get(removeILong.toInteger())
        exerciseInstance.gapFillExerciseStrings.remove(gapFillExerciseString)
        render template: "gap_fill_exercise_string_list", model: [instance: exerciseInstance, editOrCreate: "edit", isSavedText:  params.isSavedText]
    }
}
