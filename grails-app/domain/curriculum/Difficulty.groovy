package curriculum

class Difficulty {
    String name


    static constraints = {
        name(nullable: false)
    }

    String toString() {
        name
    }

    static searchable = true
}
