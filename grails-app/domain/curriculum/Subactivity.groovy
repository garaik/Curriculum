package curriculum

/**
 * Subordinates of {@link Activity}. Its purpose is to fine tune exercise categories.
 */
class Subactivity implements Comparable {
    String name
    Activity activity

    static belongsTo = Activity

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    static searchable = true

    String toString() {
        name
    }

    @Override
    int compareTo(obj) {
        name?.compareTo(obj.name) ?: 0
    }
}
