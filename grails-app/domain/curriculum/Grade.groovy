package curriculum

/**
 * Defines a grade which under the exercises are categorized.
 */
class Grade {
    String name

    static hasMany = [ activities : Activity ]

    static constraints = {
        name(nullable: false, blank: false)
    }

    static searchable = true

    String toString() {
        name
    }
}
