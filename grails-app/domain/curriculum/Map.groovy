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
    Exercise exercise
    Question question

    static hasMany = [mapArea: MapArea, mediaItems: MediaItem]
}

