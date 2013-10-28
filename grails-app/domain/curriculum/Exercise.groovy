package curriculum

/**
 * Represents an exercise what is the base entity of the application. The main goal of the application
 * is to collect data for creating the actual exercises.
 */
class Exercise {

    String title
    String instruction
    String mediaDescription
    String methodologySuggestion
    Activity activity

    static hasMany = [ gradeDetails : GradeDetails, subactivities : Subactivity, questions: Question, capabilities: Capability, tags: Tag, mediaItems: MediaItem, exerciseQueueItem: ExerciseQueueItem ]

    static mapping = {
        gradeDetails cascade: "all-delete-orphan"
    }

    static constraints = {
        activity(nullable: false)
        subactivities(nullable: true)

        title(blank: false)
        instruction(nullable: true)
        mediaDescription(nullable: true)
        methodologySuggestion(nullable: true)
    }

    static searchable = true
}
