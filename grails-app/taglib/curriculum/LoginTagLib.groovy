package curriculum

class LoginTagLib {
    def loginControl = {
        if (session.user) {
            out << "Hello ${session.user.name} "
            out << """[${link(action: "logout", controller: "user") { "Logout" }}]"""
        }
    }
}
