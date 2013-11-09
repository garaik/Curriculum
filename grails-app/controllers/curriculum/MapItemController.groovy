package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MapItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        params.max = Math.min(max ?: 10, 100)
        [mapItemInstanceList: MapItem.list(params), mapItemInstanceTotal: MapItem.count()]
    }

    def create() {
        [mapItemInstance: new MapItem(params)]
    }

    def save() {
        def mapItemInstance = new MapItem(params)
        if (!mapItemInstance.save(flush: true)) {
            render(view: "create", model: [mapItemInstance: mapItemInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mapItem.label', default: 'MapItem'), mapItemInstance.id])
        redirect(action: "show", id: mapItemInstance.id)
    }

    def show(Long id) {
        def mapItemInstance = MapItem.get(id)
        if (!mapItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "list")
            return
        }

        [mapItemInstance: mapItemInstance]
    }

    def edit(Long id) {
        def mapItemInstance = MapItem.get(id)
        if (!mapItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "list")
            return
        }

        [mapItemInstance: mapItemInstance]
    }

    def update(Long id, Long version) {
        def mapItemInstance = MapItem.get(id)
        if (!mapItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mapItemInstance.version > version) {
                mapItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mapItem.label', default: 'MapItem')] as Object[],
                        "Another user has updated this MapItem while you were editing")
                render(view: "edit", model: [mapItemInstance: mapItemInstance])
                return
            }
        }

        mapItemInstance.properties = params

        if (!mapItemInstance.save(flush: true)) {
            render(view: "edit", model: [mapItemInstance: mapItemInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mapItem.label', default: 'MapItem'), mapItemInstance.id])
        redirect(action: "show", id: mapItemInstance.id)
    }

    def delete(Long id) {
        def mapItemInstance = MapItem.get(id)
        if (!mapItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "list")
            return
        }

        try {
            mapItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mapItem.label', default: 'MapItem'), id])
            redirect(action: "show", id: id)
        }
    }
}
