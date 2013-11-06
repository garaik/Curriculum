package curriculum

import org.springframework.dao.DataIntegrityViolationException

class MapController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def acceptableVideos
    def acceptableImages
    def acceptableSounds
    def acceptableDocuments

    MapController() {
        def mediaItemController = new MediaItemController()
        acceptableVideos = mediaItemController.acceptableVideos
        acceptableImages = mediaItemController.acceptableImages
        acceptableSounds = mediaItemController.acceptableSounds
        acceptableDocuments = mediaItemController.acceptableDocuments
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mapInstanceList: Map.list(params), mapInstanceTotal: Map.count()]
    }

    def create() {
        [mapInstance: new Map(params)]
    }

    def save() {
        def mapInstance = new Map(params)
        if (!mapInstance.save(flush: true)) {
            render(view: "create", model: [mapInstance: mapInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'map.label', default: 'Map'), mapInstance.id])
        redirect(action: "show", id: mapInstance.id)
    }

    def show(Long id) {
        def mapInstance = Map.get(id)
        if (!mapInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "list")
            return
        }

        [mapInstance: mapInstance]
    }

    def edit(Long id) {
        def mapInstance = Map.get(id)
        if (!mapInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "list")
            return
        }

        [mapInstance: mapInstance]
    }

    def update(Long id, Long version) {
        def mapInstance = Map.get(id)
        if (!mapInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mapInstance.version > version) {
                mapInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'map.label', default: 'Map')] as Object[],
                        "Another user has updated this Map while you were editing")
                render(view: "edit", model: [mapInstance: mapInstance])
                return
            }
        }

        mapInstance.properties = params

        if (!mapInstance.save(flush: true)) {
            render(view: "edit", model: [mapInstance: mapInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'map.label', default: 'Map'), mapInstance.id])
        redirect(action: "show", id: mapInstance.id)
    }

    def delete(Long id) {
        def mapInstance = Map.get(id)
        if (!mapInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "list")
            return
        }

        try {
            mapInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'map.label', default: 'Map'), id])
            redirect(action: "show", id: id)
        }
    }

    def addMapItem(){
        Long exerciseId
        if (!params.id){
            def pairingExercise = new PairingExercise(params)
            if (!pairingExercise.save(flush: true)) {
                render(controller: 'pairingExercise', view: "create", model: [instance: pairingExercise])
                return
            }
            exerciseId = pairingExercise.id
        }else {
            exerciseId = Long.parseLong(params.id)
        }
        def pairingExercise = PairingExercise.get(exerciseId)
        def mapItem = new MapItem()
        Integer sequence = pairingExercise.map?.mapItems?.size()
        render(template: 'mapItem_create_template', model: [mapItemInstance: mapItem, sequence: sequence])
    }

    def saveMapItem(){
        if (params.editMapItemId){
            def originalMapItem = MapItem.get(params.editMapItemId)
            originalMapItem.properties = params
            if (!originalMapItem.save(flush: true)){
                Integer sequence = originalMapItem.map?.mapItems?.size()
                render(template: 'mapItem_create_template', model: [mapItemInstance: originalMapItem, sequence: sequence])
            }
            render(template: 'pairing_map_form', model: [mapInstance: originalMapItem.map, groupList: getMapItemGroups(originalMapItem?.map?.id)])
        }else {
            if (params.id) {
                def pairingExercise = PairingExercise.get(params.id)
                MapItem mapItem = new PairingExercise(params)?.map?.mapItems[Integer.parseInt(params.sequence)]
                if (mapItem){

                    mapItem.setMap(pairingExercise.map)
                    pairingExercise.map.addToMapItems(mapItem)
                    if (!mapItem.save(flush: true)){
                        Integer sequence = pairingExercise.map?.mapItems?.size()
                        render(template: 'mapItem_create_template', model: [mapItemInstance: mapItem, sequence: sequence])
                    }
                    render(template: 'pairing_map_form', model: [mapInstance: pairingExercise.map, groupList: getMapItemGroups(pairingExercise?.map?.id)])
                }
            }
        }
    }

    def editMapItem(){
        def mapItem = MapItem.get(params.editMapItemId)
        render(template: 'mapItem_create_template', model: [mapItemInstance: mapItem, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments], editMapItemId: params.editMapItemId)
    }

    def deleteMapItem(){
        def mapItem = MapItem.get(params.deleteMapItemId)
        def map = mapItem.map
        map.removeFromMapItems(mapItem)
        if (!mapItem.delete(flush: true)) {
            //TODO set the error message if can not delete
        }
        render(template: 'pairing_map_form', model: [mapInstance: map, groupList: getMapItemGroups(map?.id)])
    }

    def cancel(){
        if (params.pairingExerciseId && !"".equals(params.pairingExerciseId)) {
            PairingExercise pairingExercise = PairingExercise.get(Long.parseLong(params.pairingExerciseId))
            render(template: 'pairing_map_form', model: [mapInstance: pairingExercise.map, groupList: getMapItemGroups(pairingExercise?.map?.id), pairingExerciseId: params.pairingExerciseId])
        }
    }

    def addGroup(){
        def pairingExercise = PairingExercise.get(params.id)
        def mapItemGroup = new MapItemGroup()
        if ("PAIRING".equals(pairingExercise.getMap().getExerciseType().name())){
            render(template: 'create_pair_template', model: [mapItemGroup: mapItemGroup, mapItemList: MapItem.findAllWhere(map: Map.get(pairingExercise.map.id))])
        }else if ("GROUPING".equals(pairingExercise.getMap().getExerciseType().name())){
            render(template: 'create_group_template', model: [mapItemGroup: mapItemGroup, mapItemList: MapItem.findAllWhere(map: Map.get(pairingExercise.map.id))])
        }
    }

    def saveGroup(){
        def pairingExercise = PairingExercise.get(params.id)
        def mapItemGroup
        if (params.editGroupId){
            mapItemGroup = MapItemGroup.get(params.editGroupId)
            mapItemGroup.properties = params
        }else {
            mapItemGroup = new MapItemGroup(params)
        }
        if (!mapItemGroup.save(flush: true)){
            render(template: 'create_pair_template', model: [mapItemGroup: mapItemGroup, mapItemList: MapItem.findAllWhere(map: Map.get(pairingExercise.map.id))])
        }else {
            render(template: 'pairing_map_form', model: [mapInstance: Map.get(pairingExercise.map.id), groupList: getMapItemGroups(pairingExercise?.map?.id)])
        }
    }

    def editGroup(){
        def mapItemGroup = MapItemGroup.findById(params.editGroupId){fetchMode }
        if ("PAIRING".equals(mapItemGroup.getMapItems().asList().get(0).map.exerciseType.name())){
            render(template: 'create_pair_template', model: [mapItemGroup: mapItemGroup, mapItemList: MapItem.findAllWhere(map: Map.get(mapItemGroup.getMapItems().asList().get(0).map.id)), editGroupId: params.editGroupId,
                    acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments])
        }else if ("GROUPING".equals(mapItemGroup.getMapItems().asList().get(0).map.exerciseType.name())){
            render(template: 'create_group_template', model: [mapItemGroup: mapItemGroup, mapItemList: MapItem.findAllWhere(map: Map.get(mapItemGroup.getMapItems().asList().get(0).map.id)), editGroupId: params.editGroupId,
                    acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments])
        }
    }

    def deleteGroup(){
        def pairingExercise = PairingExercise.get(params.id)
        def mapItemGroup = MapItemGroup.get(params.deleteGroupId)
        if (!mapItemGroup.delete(flush: true)) {
            //TODO set the error message if can not delete
        }
        render(template: 'pairing_map_form', model: [mapInstance: pairingExercise.map, groupList: getMapItemGroups(pairingExercise?.map?.id)])
    }

    def getMapItemGroups(Long mapId){
        MapItemGroup.executeQuery("SELECT distinct g FROM MapItemGroup as g LEFT JOIN g.mapItems as mi WHERE mi.id IN (SELECT i.id FROM MapItem i WHERE i.map.id = :map)", [map: mapId])
    }

}
