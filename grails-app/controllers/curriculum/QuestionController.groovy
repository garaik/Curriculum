package curriculum

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
    }

    def create() {
        if (params?.multipleChoiceExerciseId){
            def questionInstance = new Question(params)
            def multipleChoiceExerciseInstance = MultipleChoiceExercise.get(params.multipleChoiceExerciseId)
            questionInstance.setExercise(multipleChoiceExerciseInstance)
            [questionInstance: questionInstance]
        }
    }

    def save() {
        Question questionInstance = new Question(params)
        MultipleChoiceExercise mce = MultipleChoiceExercise.get(Long.parseLong(params.exerciseId))
        questionInstance.setExercise(mce)
        if (!questionInstance.save(flush: true)) {
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def show(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def edit(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def update(Long id, Long version) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'question.label', default: 'Question')] as Object[],
                        "Another user has updated this Question while you were editing")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def delete(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        try {
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "show", id: id)
        }
    }

    def addAnswer(){
        def questionInstance
        if (params.id) {
            questionInstance = Question.get(params.id)
        }else {
            questionInstance = new Question(params)
        }
        if (questionInstance.save(flush: true)) {
            if (!questionInstance.answers) {
                questionInstance.answers = []
            }
            redirect(controller: "answer", action: "create", params: [questionId: questionInstance?.id])
        }
    }

    def addFeedback(){
        def questionInstance
        if (params.id) {
            questionInstance = Question.get(params.id)
        }else {
            questionInstance = new Question(params)
        }
        if (questionInstance.save(flush: true)) {
            if (!questionInstance.feedbacks) {
                questionInstance.feedbacks = []
            }
            redirect(controller: "feedback", action: "create", params: [questionId: questionInstance?.id])
        }
    }

    def addMediaItem(){
        def questionInstance
        if (params.id) {
            questionInstance = Question.get(params.id)
        }else {
            questionInstance = new Question(params)
        }
        if (questionInstance.save(flush: true)) {
            if (!questionInstance.mediaItems) {
                questionInstance.mediaItems = []
            }
            redirect(controller: "mediaItem", action: "create", params: [questionId: questionInstance?.id])
        }
    }
}
