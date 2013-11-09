package curriculum

import org.springframework.dao.DataIntegrityViolationException

class DifficultyController {
    static allowedMethods = [update: "POST"]

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
            def hits = Difficulty.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        }
        else {
            result.instances = Difficulty.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        [instance: new Difficulty(params)]
    }

    def save() {
        def i = new Difficulty(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'Difficulty.created.message', args: [i.name])
        redirect(action: "list")
    }

    private Difficulty lookUpDifficulty(Long id) {
        def i = Difficulty.get(id)
        if (!i) {
            flash.message = message(code: 'Difficulty.not.found', args: [id])
            flash.error = true
            redirect(action: "list")
        }
        i
    }

    def edit(Long id) {
        [instance: lookUpDifficulty(id)]
    }

    def update(Long id, Long version) {
        def i = lookUpDifficulty(id)
        if (i) {
            if (version != null) {
                if (i.version > version) {
                    flash.message = message(code: 'Difficulty.optimistic.locking.failure', args: [i.name])
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

            flash.message = message(code: 'Difficulty.updated.message', args: [i.name])
            redirect(action: "list")
        }
    }

    def delete(Long id) {
        def i = lookUpDifficulty(id)
        if (i) {
            try {
                i.delete(flush: true)
                flash.message = message(code: 'Difficulty.deleted.message', args: [i.name])
                redirect(action: "list")
            }
            catch (DataIntegrityViolationException ignored) {
                flash.message = message(code: 'Difficulty.integrity.violation', args: [i.name])
                flash.error = true
                render(view: "edit", model: [instance: i])
            }
        }
    }

}
