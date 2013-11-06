package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MediaItemController {

    def acceptableVideos
    def acceptableImages
    def acceptableSounds
    def acceptableDocuments

    def questionId

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
        if (params?.questionId) {
            questionId = params?.questionId
        }
        [mediaItemInstance: new MediaItem(params), questionId: questionId]
    }

    def save() {
        def mediaItemInstance = new MediaItem(params)
        if (params?.questionId){
            def question = Question.get(Long.parseLong(params.questionId))
            mediaItemInstance.addToQuestions(question)
            question.addToMediaItems(mediaItemInstance)
            questionId = params?.questionId
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
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
                return
            }
        }

//        if (!mediaItemInstance.mediaFiles) {
//            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
//            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
//            return
//        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "create", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(action: "edit", params: [id: mediaItemInstance.id, questionId: questionId])
    }

    def show(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (params?.questionId) {
            questionId = params?.questionId
        }
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId]
    }

    def edit(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (params?.questionId) {
            questionId = params?.questionId
        }
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(action: "list")
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId]
    }

    def update(Long id, Long version) {
        def mediaItemInstance = MediaItem.get(id)
        if (params?.questionId) {
            questionId = params?.questionId
        }
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
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
                return
            }
        }

        mediaItemInstance.properties = params

//        if (!mediaItemInstance.mediaFiles) {
//            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
//            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
//            return
//        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(action: "show", params: [id: mediaItemInstance.id, questionId: questionId])
    }

    def delete(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (params?.questionId) {
            questionId = params?.questionId
        }
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller: "question", action: "edit", id: questionId)
            return
        }

        try {
            mediaItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller: "question", action: "edit", id: questionId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(controller: "question", action: "edit", id: questionId)
        }
    }

    def addMediaFile(){
        def mediaItemInstance

        if (params?.questionId) {
            questionId = params?.questionId
        }

        if (params.id) {
            mediaItemInstance = MediaItem.get(params.id)
            mediaItemInstance.properties = params
        }else {
            mediaItemInstance = new MediaItem(params)
        }

        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance, questionId: questionId])
                return
            }
        }


        if (mediaItemInstance.save(flush: true)) {
            if (!mediaItemInstance.mediaFiles) {
                mediaItemInstance.mediaFiles = []
            }
            redirect(controller: "mediaFile", action: "create", params: [mediaItemId: mediaItemInstance?.id, questionId: questionId])
        }
    }
}
