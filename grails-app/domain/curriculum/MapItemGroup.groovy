package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 24/10/13
 * Time: 17:54
 * To change this template use File | Settings | File Templates.
 */
class MapItemGroup {

    MediaItem mediaItem

    static hasMany = [mapItems: MapItem]

    static mapping = {
        mapItems cascade: 'save-update'
        mediaItem lazy: false
    }
}
