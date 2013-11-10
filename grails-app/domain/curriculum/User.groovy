package curriculum

class User {
    String login
    String name
    String password
    String email
    String role = "felhasznalo"
    boolean active

    static constraints = {
        login(size: 6..32, blank: false, unique: true)
        name(blank: false)
        password(password: true, blank: false)
        email(blank: false, email: true)
        role(inList: ["felhasznalo", "admin"], blank: false)
    }

    static searchable = true

    String toString() {
        name
    }
}
