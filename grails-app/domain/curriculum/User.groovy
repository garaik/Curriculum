package curriculum

class User {
    String login
    String name
    String password
    String email
    boolean active

    static constraints = {
        login(size: 6..32, blank: false, unique: true)
        name(blank: false)
        password(blank: false)
        email(blank: false, email: true)
    }

    static searchable = true

    String toString() {
        name
    }
}
