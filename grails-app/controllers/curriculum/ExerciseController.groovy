package curriculum

import org.springframework.dao.DataIntegrityViolationException

class ExerciseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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

    def update(Long id, Long version) {
        def i = lookUpExercise(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Exercise.optimistic.locking.failure', args: [i.id])
                    flash.error = true
                    render(view: "edit", model: [instance: i])
                    return
                }
            }

            i.properties = params

            if (!i.save(flush: true)) {
                render(view: "edit", model: [instance: i])
                return
            }

            flash.message = message(code: 'Exercise.updated.message', args: [i.id])
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
}
