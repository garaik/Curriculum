package curriculum

class Capability {
    String name

    static hasMany = [exercises: Exercise]
    static belongsTo = [Grade, Exercise]

    static constraints = {
        name(blank: false, unique: true)
    }

    static searchable = true

    String toString() {
        name
    }
}
