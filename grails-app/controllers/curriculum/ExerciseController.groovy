package curriculum

import org.springframework.dao.DataIntegrityViolationException

class ExerciseController {

    static allowedMethods = [update: "POST", delete: "POST"]

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
        [instance: lookUpExercise(id)]
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

             // code change goes here
            def removeList = elementsToRemoveFromList(params, "gradeDetails", new GradeDetails(), exerciseSavedInstance.gradeDetails)
            exerciseSavedInstance.gradeDetails.removeAll(removeList)
            // code change ends here

            exerciseSavedInstance.properties = params

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

    def addGradeDetails() {
           // add one address to the list of addresses
           def exerciseInstance = new Exercise(params)
           if (!exerciseInstance.gradeDetails) [
                   exerciseInstance.gradeDetails = []
           ]
           exerciseInstance.gradeDetails << new GradeDetails()
           render template: "exercise_form", model: [instance: exerciseInstance, formId: params.formId, elementToReplace: params.elementToReplace]
       }

       def removeGradeDetails() {
           // remove selected address from the list of addresses
           def exerciseInstance = new Exercise(params)
           def removeIx = params.removeIx
           List gradeDetailList = exerciseInstance.gradeDetails.toArray()
           def gradeDetail = gradeDetailList.get(removeIx.toInteger())
           exerciseInstance.gradeDetails.remove(gradeDetail)
           render template: "exercise_form", model: [instance: exerciseInstance, formId: params.formId, elementToReplace: params.elementToReplace]
       }

       /**
        * Returns a list with elements which can be removed from the referencing entity
        * @param params - the params which include the post parameters
        * @param domainReference - the domain referenced which we named in the _form.gsp
        * @param instanceTemplate - the object to select the referenced objects
        * @param listToRemoveFrom - the list where the deleted/kept/new elements are in
        * @return
        */
       def List elementsToRemoveFromList(params, domainReference, instanceTemplate, listToRemoveFrom) {
           def listParamElement = params["${domainReference}[0]"]
           def removeList = new ArrayList(listToRemoveFrom)
           for (int i = 1; listParamElement != null; i++) {
               log.debug "listParamElement: ${listParamElement}"
               def instanceElement = instanceTemplate.get(listParamElement.id);
               log.debug "instanceElement: ${instanceElement}"
               removeList.remove(instanceElement)
               listParamElement = params["${domainReference}[${i}]"]
           }

           return removeList
       }
}
