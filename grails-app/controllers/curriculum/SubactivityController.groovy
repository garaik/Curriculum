package curriculum

import org.slf4j.LoggerFactory
import org.springframework.dao.DataIntegrityViolationException

class SubactivityController {
    private static def log = LoggerFactory.getLogger(this)

    def beforeInterceptor = [action: this.&auth]

    def auth() {
        if (!session.user) {
            redirect(controller: "user", action: "login")
            return false
        }
    }

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
            def hits = Subactivity.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = Subactivity.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new Subactivity(params)]
    }

    def save() {
        def i = new Subactivity(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Subactivity.created.message', args: [i.name])
        redirect(action: "list")
    }

    private Subactivity lookUpSubactivity(Long id) {
        def i = Subactivity.get(id)
        if (!i) {
            flash.message = message(code: 'Subactivity.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpSubactivity(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpSubactivity(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Subactivity.optimistic.locking.failure', args: [i.name])
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

            flash.message = message(code: 'Subactivity.updated.message', args: [i.name])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpSubactivity(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Subactivity.deleted.message', args: [i.name])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Subactivity.integrity.violation', args: [i.name])
                flash.error = true
                log.error("Deleting subactivity failed (id: ${id}).")
                render(view: "edit", model: [instance: i])
            }
        }
    }
}
