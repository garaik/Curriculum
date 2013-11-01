package curriculum



class MultipleChoiceExerciseController extends ExerciseController {
    static allowedMethods = [update: "POST", save: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def pagination = new Pagination(params)
        println(pagination)
        params.max = Math.min(max ?: 10, 100)
        def listParams = pagination.listParams
        println(listParams)
        def result = [:]
        if (pagination.filter) {
            def hits = MultipleChoiceExercise.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = MultipleChoiceExercise.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        params.gradeDetails = [new GradeDetails()]
        [instance: new MultipleChoiceExercise(params)]
    }

    def save() {
        def i = new MultipleChoiceExercise(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'MultipleChoiceExercise.created.message', args: [i.id])
        redirect(action: "list")
    }

    @Override
    def show(Long id) {
        return super.show(id)
    }

    def addQuestion(){
        def multipleChoiceExerciseInstance
        if (params.id) {
            multipleChoiceExerciseInstance = MultipleChoiceExercise.get(params.id)
        }else {
            multipleChoiceExerciseInstance = new MultipleChoiceExercise(params)
        }
        if (multipleChoiceExerciseInstance.save(flush: true)) {
            if (!multipleChoiceExerciseInstance.questions) {
                multipleChoiceExerciseInstance.questions = []
            }
            redirect(controller: "question", action: "create", params: [multipleChoiceExerciseId: multipleChoiceExerciseInstance?.id])
        }else {
            render(view: "create", model: [instance: multipleChoiceExerciseInstance])
            return
        }
    }
}
