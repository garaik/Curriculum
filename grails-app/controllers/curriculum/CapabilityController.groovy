package curriculum

import org.springframework.dao.DataIntegrityViolationException

class CapabilityController {

    static allowedMethods = [ update: "POST", delete: "POST"]

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
            def hits = Capability.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        }
        else {
            result.instances = Capability.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new Capability(params)]
    }

    def save() {
        def i = new Capability(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Capability.created.message', args: [i.name])
        redirect(action: "list")
    }

    private Capability lookUpCapability(Long id) {
        def i = Capability.get(id)
        if (!i) {
            flash.message = message(code: 'Capability.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpCapability(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpCapability(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Capability.optimistic.locking.failure', args: [i.name])
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

            flash.message = message(code: 'Capability.updated.message', args: [i.name])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpCapability(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Capability.deleted.message', args: [i.name])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Capability.integrity.violation', args: [i.name])
                flash.error = true
                render(view: "edit", model: [instance: i])
            }
        }
    }
}
