package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 23/10/13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
class Tag {

    String discription

    static hasMany = [exercises: Exercise]
    static belongsTo = Exercise
}
