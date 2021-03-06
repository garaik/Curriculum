package curriculum

class PairingExerciseController extends ExerciseController {
    static allowedMethods = [update: "POST",]

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
        def pagination = new Pagination(params)
        println(pagination)
        params.max = Math.min(max ?: 10, 100)
        def listParams = pagination.listParams
        println(listParams)
        def result = [:]
        if (pagination.filter) {
            def hits = PairingExercise.search(pagination.filter, listParams)
            result.instances = hits.results
            result.count = hits.total
        } else {
            result.instances = PairingExercise.list(listParams)
            result.count = result.instances.totalCount
        }
        [instances: result.instances, count: result.count, pagination: pagination]
    }

    def create() {
        params.gradeDetails = [new GradeDetails()]
        [instance: new PairingExercise(params)]
    }

    def save() {
        def i = new PairingExercise(params)
        if (!i.save(flush: true)) {
            render(view: "create", model: [instance: i])
            return
        }
        flash.message = message(code: 'PairingExercise.created.message', args: [i.id])
        redirect(action: "list")
    }

    @Override
    def edit(Long id) {
        PairingExercise instance = lookUpExercise(id)
        return render(view: "/pairingExercise/edit", model: [instance: instance, groupList: getMapItemGroups(instance?.map?.id)])
    }

    def getMapItemGroups(Long mapId){
        MapItemGroup.executeQuery("SELECT distinct g FROM MapItemGroup as g LEFT JOIN g.mapItems as mi WHERE mi.id IN (SELECT i.id FROM MapItem i WHERE i.map.id = :map)", [map: mapId])
    }
}
