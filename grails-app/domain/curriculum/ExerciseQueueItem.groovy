package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 25/10/13
 * Time: 18:06
 * To change this template use File | Settings | File Templates.
 */
class ExerciseQueueItem {

    Exercise exercise
    ExerciseQueue exerciseQueue
    Integer exerciseOrder

    static belongsTo = [ExerciseQueue]
}
