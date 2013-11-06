package curriculum

import org.springframework.dao.DataIntegrityViolationException

class CompletiveExerciseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [completiveExerciseInstanceList: CompletiveExercise.list(params), completiveExerciseInstanceTotal: CompletiveExercise.count()]
    }

    def create() {
        [completiveExerciseInstance: new CompletiveExercise(params)]
    }

    def save() {
        def completiveExerciseInstance = new CompletiveExercise(params)
        if (!completiveExerciseInstance.save(flush: true)) {
            render(view: "create", model: [completiveExerciseInstance: completiveExerciseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), completiveExerciseInstance.id])
        redirect(action: "show", id: completiveExerciseInstance.id)
    }

    def show(Long id) {
        def completiveExerciseInstance = CompletiveExercise.get(id)
        if (!completiveExerciseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "list")
            return
        }

        [completiveExerciseInstance: completiveExerciseInstance]
    }

    def edit(Long id) {
        def completiveExerciseInstance = CompletiveExercise.get(id)
        if (!completiveExerciseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "list")
            return
        }

        [completiveExerciseInstance: completiveExerciseInstance]
    }

    def update(Long id, Long version) {
        def completiveExerciseInstance = CompletiveExercise.get(id)
        if (!completiveExerciseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (completiveExerciseInstance.version > version) {
                completiveExerciseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'completiveExercise.label', default: 'CompletiveExercise')] as Object[],
                        "Another user has updated this CompletiveExercise while you were editing")
                render(view: "edit", model: [completiveExerciseInstance: completiveExerciseInstance])
                return
            }
        }

        completiveExerciseInstance.properties = params

        if (!completiveExerciseInstance.save(flush: true)) {
            render(view: "edit", model: [completiveExerciseInstance: completiveExerciseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), completiveExerciseInstance.id])
        redirect(action: "show", id: completiveExerciseInstance.id)
    }

    def delete(Long id) {
        def completiveExerciseInstance = CompletiveExercise.get(id)
        if (!completiveExerciseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "list")
            return
        }

        try {
            completiveExerciseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'completiveExercise.label', default: 'CompletiveExercise'), id])
            redirect(action: "show", id: id)
        }
    }
}
