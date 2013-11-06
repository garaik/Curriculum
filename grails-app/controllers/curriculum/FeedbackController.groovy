package curriculum

import org.springframework.dao.DataIntegrityViolationException

class FeedbackController {

    def acceptableVideos
    def acceptableSounds
    def acceptableImages
    def acceptableDocuments

    FeedbackController () {
        init()
    }

    def init() {
        acceptableVideos = grailsApplication.metadata['mediaAllowedVideoFormats'].tokenize(',[]')
        acceptableSounds = grailsApplication.metadata['mediaAllowedAudioFormats'].tokenize(',[]')
        acceptableImages = grailsApplication.metadata['mediaAllowedImageFormats'].tokenize(',[]')
        acceptableDocuments = grailsApplication.metadata['mediaAllowedDocumentFormats'].tokenize(',[]')
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [feedbackInstanceList: Feedback.list(params), feedbackInstanceTotal: Feedback.count()]
    }

    def create() {
        [feedbackInstance: new Feedback(params)]
    }

    def save() {
        def feedbackInstance = new Feedback(params)
        if ("question".equals(params?.returnController)){
            def question = Question.get(Long.parseLong(params.returnId))
            feedbackInstance.addToQuestions(question)
            question.addToFeedbacks(feedbackInstance)
        }else if ("answer".equals(params?.returnController)){
            def answer = Answer.get(Long.parseLong(params.returnId))
            feedbackInstance.addToAnswers(answer)
            answer.addToFeedbacks(feedbackInstance)
        }
        if (!feedbackInstance.save(flush: true)) {
            render(view: "create", model: [feedbackInstance: feedbackInstance, returnController: params.returnController,
                    returnAction: params.returnAction, returnId: params.returnId])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), feedbackInstance.id])
        redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
    }

    def show(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
            return
        }

        [feedbackInstance: feedbackInstance, acceptableVideos: acceptableVideos, acceptableDocuments: acceptableDocuments, acceptableImages: acceptableImages, acceptableSounds: acceptableSounds]
    }

    def edit(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
            return
        }

        [feedbackInstance: feedbackInstance, acceptableVideos: acceptableVideos, acceptableDocuments: acceptableDocuments, acceptableImages: acceptableImages, acceptableSounds: acceptableSounds,
        returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ]
    }

    def update(Long id, Long version) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
            return
        }

        if (version != null) {
            if (feedbackInstance.version > version) {
                feedbackInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'feedback.label', default: 'Visszajelzés -')] as Object[],
                        " - Egy másik felhasználó módosította a visszajelzés adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [feedbackInstance: feedbackInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            }
        }

        feedbackInstance.properties = params

        if (!feedbackInstance.save(flush: true)) {
            render(view: "edit", model: [feedbackInstance: feedbackInstance,  returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), feedbackInstance.id])
        redirect(controller: params.returnController, action: params.returnAction, id: params.returnId)
    }

    def delete(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
            return
        }

        try {
            feedbackInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(controller:  params.returnController, action:  params.returnAction, id: params.returnId)
        }
    }

    def addMediaItem(){
        def feedbackInstance
        if (params.id) {
            feedbackInstance = Feedback.get(params.id)
            feedbackInstance.properties = params
        }else {
            feedbackInstance = new Feedback(params)
        }

        if (!feedbackInstance.validate()) {
            if (feedbackInstance.id) {
                render(view: "edit", model: [feedbackInstance: feedbackInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            } else {
                render(view: "create", model: [feedbackInstance: feedbackInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
                return
            }
        }

        if (feedbackInstance.save(flush: true)) {
            if (!feedbackInstance.mediaItems) {
                feedbackInstance.mediaItems = []
            }
            redirect(controller: "mediaItem", action: "create", params: [feedbackId: feedbackInstance?.id])
        }
    }
}
