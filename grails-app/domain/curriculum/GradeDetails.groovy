package curriculum

/**
 * @author DullB
 * @version 1.0
 * @since 19 10 2013
 */
class GradeDetails {

    Grade grade
    int duration
    Difficulty difficulty

    static belongsTo = [exercise : Exercise]

    static constraints = {
        grade(nullable: false)
        duration(nullable: false)
        difficulty(nullable: true)
    }
}
