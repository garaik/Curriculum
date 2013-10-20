package curriculum

/**
 * Represents an exercise what is the base entity of the application. The main goal of the application
 * is to collect data for creating the actual exercises.
 */
class Exercise {

    static constraints = {
        activity(nullable: false)
        subactivity(nullable: true)

        title(blank: false)
        instruction(nullable: true)
        mediaDescription(nullable: true)
        feedback(nullable: true)
        methodologySuggestion(nullable: true)
    }

    static hasMany = [ gradeDetails : GradeDetails ]

    static mapping = {
            gradeDetails cascade: "all-delete-orphan"
        }

    Activity activity
    Subactivity subactivity

    String title
    String instruction
    String mediaDescription
    String feedback
    String methodologySuggestion

    List gradeDetails

    static searchable = true
}
