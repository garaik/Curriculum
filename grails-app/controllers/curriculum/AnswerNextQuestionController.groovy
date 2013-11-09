package curriculum

import org.springframework.dao.DataIntegrityViolationException

class AnswerNextQuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        [answerNextQuestionInstanceList: AnswerNextQuestion.list(params), answerNextQuestionInstanceTotal: AnswerNextQuestion.count()]
    }

    def create() {
        [answerNextQuestionInstance: new AnswerNextQuestion(params)]
    }

    def save() {
        def answerNextQuestionInstance = new AnswerNextQuestion(params)
        if (!answerNextQuestionInstance.save(flush: true)) {
            render(view: "create", model: [answerNextQuestionInstance: answerNextQuestionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), answerNextQuestionInstance.id])
        redirect(action: "show", id: answerNextQuestionInstance.id)
    }

    def show(Long id) {
        def answerNextQuestionInstance = AnswerNextQuestion.get(id)
        if (!answerNextQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "list")
            return
        }

        [answerNextQuestionInstance: answerNextQuestionInstance]
    }

    def edit(Long id) {
        def answerNextQuestionInstance = AnswerNextQuestion.get(id)
        if (!answerNextQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "list")
            return
        }

        [answerNextQuestionInstance: answerNextQuestionInstance]
    }

    def update(Long id, Long version) {
        def answerNextQuestionInstance = AnswerNextQuestion.get(id)
        if (!answerNextQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (answerNextQuestionInstance.version > version) {
                answerNextQuestionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion')] as Object[],
                        "Another user has updated this AnswerNextQuestion while you were editing")
                render(view: "edit", model: [answerNextQuestionInstance: answerNextQuestionInstance])
                return
            }
        }

        answerNextQuestionInstance.properties = params

        if (!answerNextQuestionInstance.save(flush: true)) {
            render(view: "edit", model: [answerNextQuestionInstance: answerNextQuestionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), answerNextQuestionInstance.id])
        redirect(action: "show", id: answerNextQuestionInstance.id)
    }

    def delete(Long id) {
        def answerNextQuestionInstance = AnswerNextQuestion.get(id)
        if (!answerNextQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "list")
            return
        }

        try {
            answerNextQuestionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'answerNextQuestion.label', default: 'AnswerNextQuestion'), id])
            redirect(action: "show", id: id)
        }
    }
}
