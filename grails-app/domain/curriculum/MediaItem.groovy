package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:40
 * To change this template use File | Settings | File Templates.
 */
class MediaItem {
    String instruction
    MediaType mediaType
    String description

    static hasMany = [mediaFiles: MediaFile, exercises: Exercise, answers: Answer, feedbacks: Feedback, maps: Map, mapItems: MapItem, questions: Question]
    static belongsTo = [Exercise, Answer, Map, MapItem, Question]
    static constraints = {
        description(nullable: false)
    }

    @Override
    public java.lang.String toString() {
        return description
    }
}
