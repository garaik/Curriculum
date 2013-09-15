package curriculum

import org.slf4j.LoggerFactory

class ActivityController {
    private static def log = LoggerFactory.getLogger(this)

    def index() {
        [ items: Activity.list() ]
    }

    def view(Long id) {
        [ item: Activity.get(id) ]
    }

    def edit(Long id) {
        log.debug("Editing activity (id: ${id})...")
        [ item: Activity.get(id) ]
    }

    def create(){
        [ item : new Activity() ]
    }

    def save() {
        log.debug("Saving activity...")
        def item = new Activity(params)
        item.save()
        flash.message = "Activity has been created with id ${item.id}."
        redirect(action: "index")
    }

    def update(Long id, Long version) {
        log.debug("Updating activity (id: ${id}, version: ${version})...")
        log.debug("PARAMS:")
        params.each({ param -> log.debug("  ${param}") })

        def item = Activity.get(id)

        log.debug("BEFORE updating params:")
        logProperties(item)

        item.properties = params

        item.save()
        log.debug("AFTER updating params:")
        logProperties(item)
        flash.message = "Activity has been saved."
        redirect(action: "index", id: id)
    }

    def delete(Long id) {
        log.debug("Deleting activity (id: ${id})...")
        def item = Activity.get(id)
        item.delete()
        flash.message = "Activity with id ${item.id} has been deleted."
        redirect(action: "index")
    }

    private static logProperties(bean) {
        bean.properties.each({ property -> log.debug("  ${property}") })
    }
}
