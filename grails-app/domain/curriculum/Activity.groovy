package curriculum

/**
 * Represents an activity which into the exercises can be categorized.
 */
class Activity {
    String name
   // SortedSet subactivities
    Grade grade

    static hasMany = [ subactivities : Subactivity ]
    static belongsTo = Grade

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    static mapping = {
        subactivities(cascade: "all")
    }

    static searchable = true

    String toString() {
        name
    }
}
