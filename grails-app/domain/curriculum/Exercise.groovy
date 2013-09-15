package curriculum

/**
 * Represents an exercise what is the base entity of the application. The main goal of the application
 * is to collect data for creating the actual exercises.
 */
class Exercise {

    Grade grade
    Activity activity
    Subactivity subactivity
    int duration
    Difficulty difficulty

    String title
    String instruction
    String mediaDescription
    String feedback
    String methodologySuggestion

    static hasMany = [ capabilities : Capability ]

    static constraints = {
        grade(nullable: false)
        activity(nullable: false)
        subactivity(nullable: true)
        duration(nullable: false)
        difficulty(nullable: true)

        title(blank: false)
        instruction(nullable: true)
        mediaDescription(nullable: true)
        feedback(nullable: true)
        methodologySuggestion(nullable: true)
    }

    static searchable = true
}
