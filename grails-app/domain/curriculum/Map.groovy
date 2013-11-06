package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 20/10/13
 * Time: 15:32
 * To change this template use File | Settings | File Templates.
 */
class Map {

    ExerciseType exerciseType
    Question question
    List mapItems

    static hasMany = [mapAreas: MapArea, mapItems: MapItem]
    static belongsTo = [exercise: PairingExercise]
    static constraints = {
        question(nullable: true)
    }
    static mapping = {
//        exercise cascade: 'delete-orphan'
//        mapItems cascade: 'save-update'
        mapItems lazy: false
        exercise lazy: false
    }
}

