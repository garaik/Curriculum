package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MapItemGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mapItemGroupInstanceList: MapItemGroup.list(params), mapItemGroupInstanceTotal: MapItemGroup.count()]
    }

    def create() {
        [mapItemGroupInstance: new MapItemGroup(params)]
    }

    def save() {
        def mapItemGroupInstance = new MapItemGroup(params)
        if (!mapItemGroupInstance.save(flush: true)) {
            render(view: "create", model: [mapItemGroupInstance: mapItemGroupInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), mapItemGroupInstance.id])
        redirect(action: "show", id: mapItemGroupInstance.id)
    }

    def show(Long id) {
        def mapItemGroupInstance = MapItemGroup.get(id)
        if (!mapItemGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "list")
            return
        }

        [mapItemGroupInstance: mapItemGroupInstance]
    }

    def edit(Long id) {
        def mapItemGroupInstance = MapItemGroup.get(id)
        if (!mapItemGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "list")
            return
        }

        [mapItemGroupInstance: mapItemGroupInstance]
    }

    def update(Long id, Long version) {
        def mapItemGroupInstance = MapItemGroup.get(id)
        if (!mapItemGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mapItemGroupInstance.version > version) {
                mapItemGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mapItemGroup.label', default: 'MapItemGroup')] as Object[],
                        "Another user has updated this MapItemGroup while you were editing")
                render(view: "edit", model: [mapItemGroupInstance: mapItemGroupInstance])
                return
            }
        }

        mapItemGroupInstance.properties = params

        if (!mapItemGroupInstance.save(flush: true)) {
            render(view: "edit", model: [mapItemGroupInstance: mapItemGroupInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), mapItemGroupInstance.id])
        redirect(action: "show", id: mapItemGroupInstance.id)
    }

    def delete(Long id) {
        def mapItemGroupInstance = MapItemGroup.get(id)
        if (!mapItemGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "list")
            return
        }

        try {
            mapItemGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mapItemGroup.label', default: 'MapItemGroup'), id])
            redirect(action: "show", id: id)
        }
    }
}
