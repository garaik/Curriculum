package curriculum

class Difficulty {
    String name

    static hasMany = [ exercise : Exercise ]

    static constraints = {
        name(nullable: false, unique: true)
    }

    String toString() {
        name
    }

    static searchable = true
}
