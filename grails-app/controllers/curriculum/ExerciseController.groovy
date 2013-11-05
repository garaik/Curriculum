package curriculum

import org.springframework.dao.DataIntegrityViolationException

class ExerciseController {

    static allowedMethods = [update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def pagination = new Pagination(params)
        println(pagination)
        params.max = Math.min(max ?: 10, 100)
        def listParams = pagination.listParams
        println(listParams)
        def result = [:]
        if (pagination.filter) {
            def hits = Exercise.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        }
        else {
            result.instances = Exercise.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        params.gradeDetails = [new GradeDetails()]
        [instance: new Exercise(params)]
    }

    def save() {
        def i = new Exercise(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Exercise.created.message', args: [i.id])
        redirect(action: "list")
    }

    private Exercise lookUpExercise(Long id) {
        def i = Exercise.get(id)
        if (!i) {
            flash.message = message(code: 'Exercise.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        Exercise instance = lookUpExercise(id)
        switch ( instance ) {
        case MultipleChoiceExercise:    return render(view: "/multipleChoiceExercise/edit", model:  [instance: instance])
        case GapFillExercise:           return render(view: "/gapFillExercise/edit", model:  [instance: instance, editOrCreate: "edit", isSavedText: "true"])
        case PictureMapExercise:        return render(view: "/pictureMapExercise/edit", model:  [instance: instance])
        case PairingExercise:           return render(view: "/pairingExercise/edit", model:  [instance: instance])
        default:
         render(view: "edit", model:  [instance: instance])
        }
    }

    def update() {
        def exerciseSavedInstance = lookUpExercise(params.id.toLong())
        if (exerciseSavedInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (exerciseSavedInstance.version > version) {
                    flash.message = message(code: 'Exercise.optimistic.locking.failure', args: [exerciseSavedInstance.id])
                    flash.error = true
                    render(view: "edit", model: [instance: exerciseSavedInstance])
                    return
                }
            }

             //Remove the unused grade details
            def removeList = OneToManyUtils.elementsToRemoveFromList(params, "gradeDetails", new GradeDetails(), exerciseSavedInstance.gradeDetails)
            exerciseSavedInstance.gradeDetails.removeAll(removeList)


            exerciseSavedInstance.properties = params

            deleteUnusedSubactivities(exerciseSavedInstance)

            if (!exerciseSavedInstance.save(flush: true)) {
                render(view: "edit", model: [instance: exerciseSavedInstance])
                return
            }

            flash.message = message(code: 'Exercise.updated.message', args: [exerciseSavedInstance.id])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpExercise(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Exercise.deleted.message', args: [i.id])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Exercise.integrity.violation', args: [i.id])
                flash.error = true
                render(view: "edit", model: [instance: i])
            }
        }
    }

    /**
     * Same SubActivities have remained while user change the Activity.<br/>
     * This method deletes this unused SubActivities.
     * @param exerciseSavedInstance without orphan SubActivities.
     */
    private void deleteUnusedSubactivities(Exercise exerciseSavedInstance) {
        for (Subactivity sub : exerciseSavedInstance?.subactivities) {
            if (!sub.activity.equals(exerciseSavedInstance.activity)) {
                exerciseSavedInstance.subactivities.remove(sub)
            }
        }
    }

    /**
     *  Refresh the _exercise_activities template.<br/>
     *  This method is triggered when the user change the Activity in the _exercise_form.
     * @return renders the exercise_activities
     */
    def refreshSubactivityList() {
        def instance = new Exercise()
        if(!"null".equals(params.activity)){
            Activity activity = Activity.get(Long.valueOf(params.activity))
            instance.setActivity(activity)
        }
        render(template: "/exercise/exercise_activities", model: [instance: instance])
    }

    /**
     * Add GradeDetails to Exercise instance
     * @return renders the /exercise/exercise_form with new GradeDetails
     */
    def addGradeDetails() {
           // add one address to the list of addresses
           def exerciseInstance = new Exercise(params)
           if (!exerciseInstance.gradeDetails) [
                   exerciseInstance.gradeDetails = []
           ]
           exerciseInstance.gradeDetails << new GradeDetails()
           render template: "/exercise/exercise_grade_details", model: [instance: exerciseInstance]
       }

    /**
     * Remove GradeDetails from Exercise instance
     * @return renders the /exercise/exercise_form without the removed GradeDetails
     */
    def removeGradeDetails() {
        // remove selected address from the list of addresses
        def exerciseInstance = new Exercise(params)
        List gradeDetailList = exerciseInstance.gradeDetails.toArray()
        def gradeDetail = gradeDetailList.get(Integer.parseInt(params.removeGradeDetailIx))
        exerciseInstance.gradeDetails.remove(gradeDetail)
        render template: "/exercise/exercise_grade_details", model: [instance: exerciseInstance]
    }
}
