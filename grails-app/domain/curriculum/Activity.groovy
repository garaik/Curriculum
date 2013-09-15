package curriculum

/**
 * Represents an activity which into the exercises can be categorized.
 */
class Activity {
    String name
    SortedSet subactivities

    static hasMany = [ grades : Grade, subactivities : Subactivity ]
    static belongsTo = Grade

    static constraints = {
        name(nullable: false, blank: false)
    }

    static mapping = {
        subactivities(cascade: "all")
    }

    String toString() {
        name
    }
}
