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
        if (params?.questionId){
            def question = Question.get(Long.parseLong(params.questionId))
            mediaItemInstance.addToQuestions(question)
            question.addToMediaItems(mediaItemInstance)
        }else if (params?.answerId){
            def answer = Answer.get(Long.parseLong(params.answerId))
            mediaItemInstance.addToAnswers(answer)
            answer.addToMediaItems(mediaItemInstance)
        }else if (params?.feedbackId){
            def feedback = Feedback.get(Long.parseLong(params.feedbackId))
            mediaItemInstance.addToFeedbacks(feedback)
            feedback.addToMediaItems(mediaItemInstance)
        }

        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance])
                return
            }
        }

        if (!mediaItemInstance.mediaFiles) {
            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
            return
        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "create", model: [mediaItemInstance: mediaItemInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(action: "edit", id: mediaItemInstance.id)
    }

    def show(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def edit(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def update(Long id, Long version) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediaItemInstance.version > version) {
                mediaItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mediaItem.label', default: 'Média elem - ')] as Object[],
                        " - Egy másik felhasználó módosította a média elem adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
                return
            }
        }

        mediaItemInstance.properties = params

        if (!mediaItemInstance.mediaFiles) {
            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
            return
        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(action: "show", id: mediaItemInstance.id)
    }

    def delete(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        try {
            mediaItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "show", id: id)
        }
    }

    def addMediaFile(){
        def mediaItemInstance
        if (params.id) {
            mediaItemInstance = MediaItem.get(params.id)
        }else {
            mediaItemInstance = new MediaItem(params)
        }

        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance])
                return
            }
        }

        //TODO megoldani, hogy kiolvassa a változtatásokat edit esetben, mert nem figyeli őket
        if (mediaItemInstance.save(flush: true)) {
            if (!mediaItemInstance.mediaFiles) {
                mediaItemInstance.mediaFiles = []
            }
            redirect(controller: "mediaFile", action: "create", params: [mediaItemId: mediaItemInstance?.id])
        }
    }
}
