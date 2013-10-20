package curriculum

/**
 * Represents an activity which into the exercises can be categorized.
 */
class Activity {
    String name
   // SortedSet subactivities

    List subactivities

    static hasMany = [ subactivities : Subactivity ]

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
