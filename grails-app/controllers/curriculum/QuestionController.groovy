package curriculum

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def acceptableVideos
    def acceptableSounds
    def acceptableImages
    def acceptableDocuments

    QuestionController() {
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

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Kérdés'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def show(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance, acceptableVideos: acceptableVideos, acceptableDocuments: acceptableDocuments, acceptableImages: acceptableImages, acceptableSounds: acceptableSounds]
    }

    def edit(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance, acceptableVideos: acceptableVideos, acceptableDocuments: acceptableDocuments, acceptableImages: acceptableImages, acceptableSounds: acceptableSounds]
    }

    def update(Long id, Long version) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'question.label', default: 'Kérdés - ')] as Object[],
                        " - Egy másik felhasználó módosította a kérdés adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Kérdés'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def delete(Long id) {
        def questionInstance = Question.get(id)
        def mceId = questionInstance.exercise.id
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            return
        }
        try {
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            redirect(controller: "multipleChoiceExercise", action: "edit", id: mceId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Kérdés'), id])
            redirect(controller: "multipleChoiceExercise", action: "edit", id: mceId)
        }
    }

    def addAnswer(){
        def questionInstance
        if (params.id) {
            questionInstance = Question.get(params.id)
            questionInstance.properties = params
        }else {
            questionInstance = new Question(params)
            MultipleChoiceExercise mce = MultipleChoiceExercise.get(Long.parseLong(params.exerciseId))
            questionInstance.setExercise(mce)
        }


        if (!questionInstance.validate() ) {
            if (questionInstance.id) {
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            } else {
                render(view: "create", model: [questionInstance: questionInstance])
                return
            }
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
            questionInstance.properties = params
        }else {
            questionInstance = new Question(params)
            MultipleChoiceExercise mce = MultipleChoiceExercise.get(Long.parseLong(params.exerciseId))
            questionInstance.setExercise(mce)
        }

        if (!questionInstance.validate()) {
            if (questionInstance.id) {
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            } else {
                render(view: "create", model: [questionInstance: questionInstance])
                return
            }
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
            questionInstance.properties = params
        }else {
            questionInstance = new Question(params)
            MultipleChoiceExercise mce = MultipleChoiceExercise.get(Long.parseLong(params.exerciseId))
            questionInstance.setExercise(mce)
        }

        if (!questionInstance.validate()) {
            if (questionInstance.id) {
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            } else {
                render(view: "create", model: [questionInstance: questionInstance])
                return
            }
        }


        if (questionInstance.save(flush: true)) {
            if (!questionInstance.mediaItems) {
                questionInstance.mediaItems = []
            }
            redirect(controller: "mediaItem", action: "create", params: [questionId: questionInstance?.id])
        }
    }
}
