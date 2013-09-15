package curriculum

/**
 * Subordinates of {@link Activity}. Its purpose is to fine tune exercise categories.
 */
class Subactivity implements Comparable {
    Activity activity
    String name

    static constraints = {
        name(nullable: false, blank: false)
    }

    String toString() {
        name
    }

    @Override
    int compareTo(obj) {
        name?.compareTo(obj.name) ?: 0
    }
}
