package curriculum

import org.slf4j.LoggerFactory
import org.springframework.dao.DataIntegrityViolationException

class ActivityController {
    private static def log = LoggerFactory.getLogger(this)

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
            def hits = Activity.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = Activity.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new Activity(params)]
    }

    def save() {
        def i = new Activity(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Activity.created.message', args: [i.name])
        redirect(action: "list")
    }

    private Activity lookUpActivity(Long id) {
        def i = Activity.get(id)
        if (!i) {
            flash.message = message(code: 'Activity.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpActivity(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpActivity(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Activity.optimistic.locking.failure', args: [i.name])
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

            flash.message = message(code: 'Activity.updated.message', args: [i.name])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpActivity(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Activity.deleted.message', args: [i.name])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Activity.integrity.violation', args: [i.name])
                flash.error = true
                log.error("Deleting activity failed (id: ${id}).")
                render(view: "edit", model: [instance: i])
            }
        }
    }
}
