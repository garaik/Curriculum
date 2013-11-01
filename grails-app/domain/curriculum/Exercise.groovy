package curriculum

/**
 * Represents an exercise what is the base entity of the application. The main goal of the application
 * is to collect data for creating the actual exercises.
 */
class Exercise {

    Activity activity

    String title
    String instruction
    String mediaDescription
    String feedback
    String methodologySuggestion

    List gradeDetails

    static searchable = true

    static constraints = {
        activity(nullable: false, blank: false    )
        subactivities(nullable: false, blank: false, validator: {
                	  if (it.empty) return ['entryMissing']
                       })
        title(blank: false)
        instruction(nullable: true)
        mediaDescription(nullable: true)
        feedback(nullable: true)
        methodologySuggestion(nullable: true)
    }

    static hasMany = [ gradeDetails : GradeDetails, subactivities : Subactivity]

    static mapping = {
        tablePerHierarchy(false)
        gradeDetails cascade: "all-delete-orphan"
    }


    @Override
    public java.lang.String toString() {
        return title
    }
}
