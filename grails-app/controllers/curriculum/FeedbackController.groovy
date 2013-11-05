package curriculum

import org.springframework.dao.DataIntegrityViolationException

class FeedbackController {

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
        if (params?.questionId){
            def question = Question.get(Long.parseLong(params.questionId))
            feedbackInstance.addToQuestions(question)
            question.addToFeedbacks(feedbackInstance)
        }else if (params?.answerId){
            def answer = Answer.get(Long.parseLong(params.answerId))
            feedbackInstance.addToAnswers(answer)
            answer.addToFeedbacks(feedbackInstance)
        }
        if (!feedbackInstance.save(flush: true)) {
            render(view: "create", model: [feedbackInstance: feedbackInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), feedbackInstance.id])
        redirect(action: "show", id: feedbackInstance.id)
    }

    def show(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
            return
        }

        [feedbackInstance: feedbackInstance]
    }

    def edit(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
            return
        }

        [feedbackInstance: feedbackInstance]
    }

    def update(Long id, Long version) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
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
        redirect(action: "show", id: feedbackInstance.id)
    }

    def delete(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
            return
        }

        try {
            feedbackInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'feedback.label', default: 'Visszajelzés'), id])
            redirect(action: "show", id: id)
        }
    }

    def addMediaItem(){
        def feedbackInstance
        if (params.id) {
            feedbackInstance = Feedback.get(params.id)
        }else {
            feedbackInstance = new Feedback(params)
        }
        if (feedbackInstance.save(flush: true)) {
            if (!feedbackInstance.mediaItems) {
                feedbackInstance.mediaItems = []
            }
            redirect(controller: "mediaItem", action: "create", params: [feedbackId: feedbackInstance?.id])
        }
    }
}
