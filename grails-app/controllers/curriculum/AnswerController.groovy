package curriculum

import org.springframework.dao.DataIntegrityViolationException

class AnswerController {

    static allowedMethods = [create: "get", save: "POST", update: "POST", delete: "post"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [answerInstanceList: Answer.list(params), answerInstanceTotal: Answer.count()]
    }

    def create() {
        if (params?.questionId){
            def answerInstance = new Answer(params)
            def question = Question.get(params.questionId)
            answerInstance.setQuestion(question)
            question.answers.add(answerInstance)
            [answerInstance: answerInstance, nextQuestionList: getNextQuestionListByQuestionId(Long.parseLong(params.questionId))]
        }
    }

    def save() {
        def answerInstance = new Answer(params)
        def question = Question.get(params.questionId)
        answerInstance.setQuestion(question)
        if (params?.nextQuestionId && params?.nextQuestionId != "null"){
            def nextQuestion = Question.get(Long.parseLong(params.nextQuestionId))
            def answerNextQuestion = new AnswerNextQuestion()
            answerNextQuestion.setExercise(question.exercise)
            answerNextQuestion.setPreviousAnswer(answerInstance)
            answerNextQuestion.setNextQuestion(nextQuestion)
            if (!answerNextQuestion.save(flush: true)) {
                render(view: "create", model: [answerInstance: answerInstance])
                return
            }
            answerInstance.setNextQuestion(answerNextQuestion)
        }
        if (!answerInstance.save(flush: true)) {
            render(view: "create", model: [answerInstance: answerInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Válasz'), answerInstance.id])

        redirect(controller: "question", action: "edit", id: answerInstance.question.id)
    }

    def show(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance]
    }

    def edit(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(action: "list")
            return
        }

        [answerInstance: answerInstance, nextQuestionList: getNextQuestionListByAnswerId(id)]
    }

    def update(Long id, Long version) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (answerInstance.version > version) {
                answerInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'answer.label', default: 'Válasz - ')] as Object[],
                        " - Egy másik felhasználó módosította a válasz adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [answerInstance: answerInstance])
                return
            }
        }

        answerInstance.properties = params
        if (params.nextQuestionId != "null") {
            AnswerNextQuestion answerNextQuestion = answerInstance.nextQuestion
            if (answerNextQuestion == null){
                answerNextQuestion = new AnswerNextQuestion()
                answerNextQuestion.setExercise(answerInstance?.question?.exercise)
                answerNextQuestion.setPreviousAnswer(answerInstance)
            }
            answerNextQuestion.setNextQuestion(Question.get(Long.parseLong(params.nextQuestionId)))
            answerInstance.setNextQuestion(answerNextQuestion)
        }else if (params.nextQuestionId == "null" && answerInstance.nextQuestion != null){
            answerInstance.nextQuestion.delete()
            answerInstance.setNextQuestion(null)
        }

        if (!answerInstance.save(flush: true)) {
            render(view: "edit", model: [answerInstance: answerInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'answer.label', default: 'Válasz'), answerInstance.id])
        redirect(action: "show", id: answerInstance.id)
    }

    def delete(Long id) {
        def answerInstance = Answer.get(id)
        if (!answerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(action: "list")
            return
        }

        try {
            answerInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(controller: "question", action: "edit", id: answerInstance?.question?.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'answer.label', default: 'Válasz'), id])
            redirect(action: "show", id: id)
        }
    }

    def addFeedback(){
        def answerInstance
        if (params.id) {
            answerInstance = Answer.get(params.id)
        }else {
            answerInstance = new Answer(params)
            Question question = Question.get(Long.parseLong(params.questionId))
            answerInstance.setQuestion(question)
        }

        if (!answerInstance.validate()) {
            if (answerInstance.id) {
                render(view: "edit", model: [answerInstance: answerInstance])
                return
            } else {
                render(view: "create", model: [answerInstance: answerInstance])
                return
            }
        }

        //TODO megoldani, hogy kiolvassa a változtatásokat edit esetben, mert nem figyeli őket
        if (answerInstance.save(flush: true)) {
            if (!answerInstance.feedbacks) {
                answerInstance.feedbacks = []
            }
            redirect(controller: "feedback", action: "create", params: [answerId: answerInstance?.id])
        }
    }

    def addMediaItem(){
        def answerInstance
        if (params.id) {
            answerInstance = Answer.get(params.id)
        }else {
            answerInstance = new Answer(params)
            Question question = Question.get(Long.parseLong(params.questionId))
            answerInstance.setQuestion(question)
        }

        if (!answerInstance.validate()) {
            if (answerInstance.id) {
                render(view: "edit", model: [answerInstance: answerInstance])
                return
            } else {
                render(view: "create", model: [answerInstance: answerInstance])
                return
            }
        }

        //TODO megoldani, hogy kiolvassa a változtatásokat edit esetben, mert nem figyeli őket
        if (answerInstance.save(flush: true)) {
            if (!answerInstance.mediaItems) {
                answerInstance.mediaItems = []
            }
            redirect(controller: "mediaItem", action: "create", params: [answerId: answerInstance?.id])
        }
    }

    def getNextQuestionListByAnswerId(Long answerId){
        def answerInstance = Answer.get(answerId)
        Question.findAll("from Question as q where q.exercise = :exercise", [exercise: answerInstance.question.exercise])
    }

    def getNextQuestionListByQuestionId(Long questionId){
        def questionInstance = Question.get(questionId)
        Question.findAll("from Question as q where q.exercise = :exercise ", [exercise: questionInstance.exercise])
    }
}
