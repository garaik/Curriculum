package curriculum

import org.springframework.dao.DataIntegrityViolationException

class GradeDetailsController {

    static allowedMethods = [update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [gradeDetailsInstanceList: GradeDetails.list(params), gradeDetailsInstanceTotal: GradeDetails.count()]
    }

    def create() {
        [gradeDetailsInstance: new GradeDetails(params)]
    }

    def save() {
        def gradeDetailsInstance = new GradeDetails(params)
        if (!gradeDetailsInstance.save(flush: true)) {
            render(view: "create", model: [gradeDetailsInstance: gradeDetailsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), gradeDetailsInstance.id])
        redirect(action: "show", id: gradeDetailsInstance.id)
    }

    def show(Long id) {
        def gradeDetailsInstance = GradeDetails.get(id)
        if (!gradeDetailsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "list")
            return
        }

        [gradeDetailsInstance: gradeDetailsInstance]
    }

    def edit(Long id) {
        def gradeDetailsInstance = GradeDetails.get(id)
        if (!gradeDetailsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "list")
            return
        }

        [gradeDetailsInstance: gradeDetailsInstance]
    }

    def update(Long id, Long version) {
        def gradeDetailsInstance = GradeDetails.get(id)
        if (!gradeDetailsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (gradeDetailsInstance.version > version) {
                gradeDetailsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'gradeDetails.label', default: 'GradeDetails')] as Object[],
                        "Another user has updated this GradeDetails while you were editing")
                render(view: "edit", model: [gradeDetailsInstance: gradeDetailsInstance])
                return
            }
        }

        gradeDetailsInstance.properties = params

        if (!gradeDetailsInstance.save(flush: true)) {
            render(view: "edit", model: [gradeDetailsInstance: gradeDetailsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), gradeDetailsInstance.id])
        redirect(action: "show", id: gradeDetailsInstance.id)
    }

    def delete(Long id) {
        def gradeDetailsInstance = GradeDetails.get(id)
        if (!gradeDetailsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "list")
            return
        }

        try {
            gradeDetailsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'gradeDetails.label', default: 'GradeDetails'), id])
            redirect(action: "show", id: id)
        }
    }
}
