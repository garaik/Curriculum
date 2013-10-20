package curriculum

/**
 * Defines a grade which under the exercises are categorized.
 */
class Grade {
    String name

    static searchable = true

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    String toString() {
        name
    }
}
