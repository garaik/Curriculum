package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:59
 * To change this template use File | Settings | File Templates.
 */
class Feedback {
    String description
    boolean systemFeedback
    boolean correct

    static hasMany = [ mediaItems: MediaItem, questions: Question, answers: Answer]
    static belongsTo = [MediaItem, Question, Answer]
    static mapping = {
        questions cascade: 'delete-orphan'
    }

    static constraints = {
        description blank: false
    }

    @Override
    public java.lang.String toString() {
        return description
    }
}
