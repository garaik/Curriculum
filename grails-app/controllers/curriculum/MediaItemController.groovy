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
        [mediaItemInstanceList: MediaItem.list(params), mediaItemInstanceTotal: MediaItem.count()]
    }

    def create() {

        [mediaItemInstance: new MediaItem(params)]
    }

    def save() {
        def mediaItemInstance = new MediaItem(params)
        if (!mediaItemInstance.validate()) {
            if (mediaItemInstance.id) {
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance])
                return
            }
        }

//        if (!mediaItemInstance.mediaFiles) {
//            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
//            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId ])
//            return
//        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "create", model: [mediaItemInstance: mediaItemInstance])
            return
        }

        HashMap returnPosition = NavigationUtils.getReturnController(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance.id))
        if ("question".equals(returnPosition.get("controller"))){
            def question = Question.get(returnPosition.get("id"))
            mediaItemInstance.addToQuestions(question)
            question.addToMediaItems(mediaItemInstance)
        }else if ("answer".equals(returnPosition.get("controller"))){
            def answer = Answer.get(returnPosition.get("id"))
            mediaItemInstance.addToAnswers(answer)
            answer.addToMediaItems(mediaItemInstance)
        }else if ("feedback".equals(returnPosition.get("controller"))){
            def feedback = Feedback.get(returnPosition.get("id"))
            mediaItemInstance.addToFeedbacks(feedback)
            feedback.addToMediaItems(mediaItemInstance)
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance?.id)))
    }

    def show(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", null)))
            return
        }

        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos,
                acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def edit(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", null)))
            return
        }
        NavigationUtils.addControllerToNavigationList(session,
                new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance.id, breadCrumbsText: "Média elem szerkesztése"),true)
        [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos,
                acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def update(Long id, Long version) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", null)))
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

//        if (!mediaItemInstance.mediaFiles) {
//            flash.error = message(code: 'media.item.noFile', default: "Nincs média file csatolva!")
//            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, returnController: params.returnController, returnAction: params.returnAction, returnId: params.returnId])
//            return
//        }

        if (!mediaItemInstance.save(flush: true)) {
            render(view: "edit", model: [mediaItemInstance: mediaItemInstance, acceptableSounds: acceptableSounds,
                    acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), mediaItemInstance.id])
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance?.id)))
    }

    def delete(Long id) {
        def mediaItemInstance = MediaItem.get(id)
        if (!mediaItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", null)))
            return
        }

        try {
            HashMap returnPosition = NavigationUtils.getReturnController(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance.id))
            if ("question".equals(returnPosition.get("controller"))){
                def question = Question.get(returnPosition.get("id"))
                mediaItemInstance.removeFromQuestions(question)
            }else if ("answer".equals(returnPosition.get("controller"))){
                def answer = Answer.get(returnPosition.get("id"))
                mediaItemInstance.removeFromAnswers(answer)
            }else if ("feedback".equals(returnPosition.get("controller"))){
                def feedback = Feedback.get(returnPosition.get("id"))
                mediaItemInstance.removeFromFeedbacks(feedback)
            }
            mediaItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance?.id)))
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaItem.label', default: 'Média elem'), id])
            redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance?.id)))
        }
    }

    def cancel(){
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session, null))
    }

    def cancelAfterSave(){
        def i = MediaItem.get(params.instandceId)
        redirect(NavigationUtils.returnPositionFromControllerNavigationList(session,  new ControllerNavigation(controller: "mediaItem", action: "edit", id: i?.id)))
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
                render(view: "edit", model: [mediaItemInstance: mediaItemInstance])
                return
            } else {
                render(view: "create", model: [mediaItemInstance: mediaItemInstance])
                return
            }
        }


        if (mediaItemInstance.save(flush: true)) {
            if (mediaItemInstance.mediaFiles ==  null) {
                mediaItemInstance.mediaFiles = []
            }
            NavigationUtils.addControllerToNavigationList(session,
                    new ControllerNavigation(controller: "mediaItem", action: "edit", id: mediaItemInstance.id, breadCrumbsText: "Média elem szerkesztése"), false)
            redirect(controller: "mediaFile", action: "create", params: [mediaItemId: mediaItemInstance?.id])
        }
    }
}
