package curriculum

class Capability {
    String name

    static constraints = {
        name(blank: false, unique: true)
    }

    static searchable = true

    String toString() {
        name
    }

    static belongsTo = Grade
}
