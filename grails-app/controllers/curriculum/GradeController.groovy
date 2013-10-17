package curriculum

import org.springframework.dao.DataIntegrityViolationException

class GradeController {

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
            def hits = Grade.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = Grade.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new Grade(params)]
    }

    def save() {
        def i = new Grade(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Grade.created.message', args: [i.name])
        redirect(action: "list")
    }

    private Grade lookUpGrade(Long id) {
        def i = Grade.get(id)
        if (!i) {
            flash.message = message(code: 'Grade.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpGrade(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpGrade(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Grade.optimistic.locking.failure', args: [i.name])
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

            flash.message = message(code: 'Grade.updated.message', args: [i.name])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpGrade(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Grade.deleted.message', args: [i.name])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Grade.integrity.violation', args: [i.name])
                flash.error = true
                render(view: "edit", model: [instance: i])
            }
        }
    }
}
