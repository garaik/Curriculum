package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MediaItemController {

    def acceptableVideos
    def acceptableImages
    def acceptableSounds
    def acceptableDocuments


    MediaItemController() {
        init()
    }

    def init() {
        // Getting accessable formats for media uploading from application.properties file
        acceptableVideos = grailsApplication.metadata['mediaAllowedVideoFormats'].tokenize(',[]')
        acceptableImages = grailsApplication.metadata['mediaAllowedImageFormats'].tokenize(',[]')
        acceptableSounds = grailsApplication.metadata['mediaAllowedAudioFormats'].tokenize(',[]')
        acceptableDocuments = grailsApplication.metadata['mediaAllowedDocumentFormats'].tokenize(',[]')
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mediaItemInstanceList: MediaItem.list(params), mediaItemInstanceTotal: MediaItem.count()]
    }

    def create() {

        [mediaItemInstance: new MediaItem(params)]
    }

    def save() {
        def mediaItemInstance = new MediaItem(params)
        if ("question".equals(params?.returnController)){
            def question = Question.get(Long.parseLong(params.returnId))
            mediaItemInstance.addToQuestions(question)
            question.addToMediaItems(mediaItemInstance)
        }else if ("answer".equals(params?.returnController)){
            def answer = Answer.get(Long.parseLong(params.returnId))
            mediaItemInstance.addToAnswers(answer)
            answer.addToMediaItems(mediaItemInstance)
        }else if ("feedback".equals(params?.returnController)){
            def feedback = Feedback.get(Long.parseLong(params.returnId))
            mediaItemInstance.addToFeedbacks(feedback)
            feedback.addToMediaItems(mediaItemInstance)
        }

        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ])
                return
            }
        }

        if (!mediaItemInstance.mediaFiles) {
            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ])
            return
        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "create", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
    }

    def show(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos,
                acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def edit(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos,
                acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments,
                returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ]
    }

    def update(Long id, Long version) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
            return
        }

        if (version != null) {
            if (mediaItemInstance.version > version) {
                mediaItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mediaItem.label', default: 'Média elem - ')] as Object[],
                        " - Egy másik felhasználó módosította a média elem adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            }
        }

        mediaItemInstance.properties = params

        if (!mediaItemInstance.mediaFiles) {
            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
            return
        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds,
                    acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments,
                    returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
    }

    def delete(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
            return
        }

        try {
            mediaItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
        }
    }

    def addMediaFile(){
        def mediaItemInstance
        if (params.id) {
            mediaItemInstance = MediaItem.get(params.id)
            mediaItemInstance.properties = params
        }else {
            mediaItemInstance = new MediaItem(params)
        }

        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            }
        }


        if (mediaItemInstance.save(flush: true)) {
            if (!mediaItemInstance.mediaFiles) {
                mediaItemInstance.mediaFiles = []
            }
            redirect(controller: "mediaFile", action: "create", params: [mediaItemId: mediaItemInstance?.id, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
        }
    }
}
