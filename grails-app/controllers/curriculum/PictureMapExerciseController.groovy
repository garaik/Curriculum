package curriculum

class PictureMapExerciseController extends ExerciseController {
    static allowedMethods = [update: "POST",]

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
                 def hits = PictureMapExercise.search(pagination.filter, listParams)
                 result.instances = hits.results
                 result.count = hits.total
             }
             else {
                 result.instances = PictureMapExercise.list(listParams)
                 result.count = result.instances.totalCount
             }
             [instances: result.instances, count: result.count, pagination: pagination]
         }

         def create() {
             params.gradeDetails = [new GradeDetails()]
             [instance: new PictureMapExercise(params)]
         }

         def save() {
             def i = new PictureMapExercise(params)
             if (!i.save(flush: true)) {
                 render(view: "create", model: [instance: i])
                 return
             }
             flash.message = message(code: 'PictureMapExercise.created.message', args: [i.id])
             redirect(action: "list")
         }
}
