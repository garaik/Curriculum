package curriculum

import org.springframework.dao.DataIntegrityViolationException

class UserController {

    static allowedMethods = [ update: "POST", delete: "POST"]

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
            def hits = User.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        }
        else {
            result.instances = User.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new User(params)]
    }

    def save() {
        def i = new User(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'User.created.message', args: [i.login])
        redirect(action: "list")
    }

    private User lookUpUser(Long id) {
        def i = User.get(id)
        if (!i) {
            flash.message = message(code: 'User.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpUser(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpUser(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'User.optimistic.locking.failure', args: [i.login])
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

            flash.message = message(code: 'User.updated.message', args: [i.login])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpUser(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'User.deleted.message', args: [i.login])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'User.integrity.violation', args: [i.login])
                flash.error = true
                render(view: "edit", model: [instance: i])
            }
        }
    }
}
