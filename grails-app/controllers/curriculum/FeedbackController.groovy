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
        [feedbackInstanceList: Feedback.list(params), feedbackInstanceTotal: Feedback.count()]
    }

    def create() {
        [feedbackInstance: new Feedback(params)]
    }

    def save() {
        def feedbackInstance = new Feedback(params)
        if (!feedbackInstance.save(flush: true)) {
            render(view: "create", model: [feedbackInstance: feedbackInstance])
            return
        }
        setOwnerEntity(feedbackInstance)
        flash.message = message(code: 'default.created.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), feedbackInstance.id])
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
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
        NavigationUtils.addControllerToNavigationList(session,
                new ControllerNavigation(controller: "feedback", action: "edit", id: feedbackInstance.id, breadCrumbsText: "Visszajelzés szerkesztése"),true)
        [feedbackInstance: feedbackInstance, acceptableVideos: acceptableVideos, acceptableDocuments: acceptableDocuments, acceptableImages: acceptableImages, acceptableSounds: acceptableSounds]
    }

    def update(Long id, Long version) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
            return
        }

        if (version != null) {
            if (feedbackInstance.version > version) {
                feedbackInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'feedback.label', default: 'Visszajelzés -')] as Object[],
                        " - Egy másik felhasználó módosította a visszajelzés adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [feedbackInstance: feedbackInstance])
                return
            }
        }

        feedbackInstance.properties = params

        if (!feedbackInstance.save(flush: true)) {
            render(view: "edit", model: [feedbackInstance: feedbackInstance])
            return
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), feedbackInstance.id])
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
    }

    def delete(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
            return
        }

        try {
            HashMap returnPosition = NavigationUtils.getReturnController(session, new ControllerNavigation(controller: "feedback", action: "edit", id: feedbackInstance.id))
            if ("question".equals(returnPosition.get("controller"))) {
                def question = Question.get(returnPosition.get("id"))
                feedbackInstance.removeFromQuestions(question)
            } else if ("answer".equals(returnPosition.get("controller"))) {
                def answer = Answer.get(returnPosition.get("id"))
                feedbackInstance.removeFromAnswers(answer)
            }

            feedbackInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "feedback", action: "edit", id:feedbackInstance?.id)))
        }
    }

    def cancel(){
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, null))
    }

    def cancelAfterSave(){
        def i = Feedback.get(params.instandceId)
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session,  new ControllerNavigation(controller: "feedback", action: "edit", id: i?.id)))
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
                render(view: "edit", model: [feedbackInstance: feedbackInstance])
                return
            } else {
                render(view: "create", model: [feedbackInstance: feedbackInstance])
                return
            }
        }

        if (feedbackInstance.save(flush: true)) {
            if (feedbackInstance.mediaItems == null) {
                feedbackInstance.mediaItems = []
            }
            setOwnerEntity(feedbackInstance)
            NavigationUtils.addControllerToNavigationList(session,
                    new ControllerNavigation(controller: "feedback", action: "edit", id: feedbackInstance.id, breadCrumbsText: "Visszajelzés szerkesztése"),false)
            redirect(controller: "mediaItem", action: "create", params: [feedbackId: feedbackInstance?.id])
        }
    }

    private void setOwnerEntity(Feedback feedbackInstance) {
        HashMap returnPosition = NavigationUtils.getReturnController(session, new ControllerNavigation(controller: "feedback", action: "edit", id: feedbackInstance?.id))
        if ("question".equals(returnPosition.get("controller"))) {
            def question = Question.get(returnPosition.get("id"))
            feedbackInstance.addToQuestions(question)
            question.addToFeedbacks(feedbackInstance)
        } else if ("answer".equals(returnPosition.get("controller"))) {
            def answer = Answer.get(returnPosition.get("id"))
            feedbackInstance.addToAnswers(answer)
            answer.addToFeedbacks(feedbackInstance)
        }
    }
}
