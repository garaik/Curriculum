package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MediaFileController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mediaFileInstanceList: MediaFile.list(params), mediaFileInstanceTotal: MediaFile.count()]
    }

    def create() {
        if (params?.mediaItemId) {
            def mediaFileInstance = new MediaFile(params)
            mediaFileInstance.setMediaItem(MediaItem.get(Long.parseLong(params.mediaItemId)))
            [mediaFileInstance: mediaFileInstance]
        }
    }

    def save() {
        if (params.mediaItemId) {
            def mediaFileInstance = new MediaFile(params)
            mediaFileInstance.setMediaItem(MediaItem.get(Long.parseLong(params?.mediaItemId)))
            if (!mediaFileInstance.save(flush: true)) {
                render(view: "create", model: [mediaFileInstance: mediaFileInstance])
                return
            }

            flash.message = message(code: 'default.created.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), mediaFileInstance.id])
            redirect(action: "show", id: mediaFileInstance.id)
        }
    }

    def show(Long id) {
        def mediaFileInstance = MediaFile.get(id)
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "list")
            return
        }

        [mediaFileInstance: mediaFileInstance]
    }

    def edit(Long id) {
        def mediaFileInstance = MediaFile.get(id)
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "list")
            return
        }

        [mediaFileInstance: mediaFileInstance]
    }

    def update(Long id, Long version) {
        def mediaFileInstance = MediaFile.get(id)
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediaFileInstance.version > version) {
                mediaFileInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mediaFile.label', default: 'MediaFile')] as Object[],
                        "Another user has updated this MediaFile while you were editing")
                render(view: "edit", model: [mediaFileInstance: mediaFileInstance])
                return
            }
        }

        mediaFileInstance.properties = params

        if (!mediaFileInstance.save(flush: true)) {
            render(view: "edit", model: [mediaFileInstance: mediaFileInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), mediaFileInstance.id])
        redirect(action: "show", id: mediaFileInstance.id)
    }

    def delete(Long id) {
        def mediaFileInstance = MediaFile.get(id)
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "list")
            return
        }

        try {
            mediaFileInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaFile.label', default: 'MediaFile'), id])
            redirect(action: "show", id: id)
        }
    }
}
