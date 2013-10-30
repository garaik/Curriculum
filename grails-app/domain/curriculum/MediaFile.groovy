package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:46
 * To change this template use File | Settings | File Templates.
 */
class MediaFile {
    String path
    boolean finalVersion
    boolean isIcon

    static belongsTo = [mediaItems: MediaItem]
}
