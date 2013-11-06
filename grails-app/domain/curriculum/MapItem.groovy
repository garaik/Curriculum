package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:35
 * To change this template use File | Settings | File Templates.
 */
class MapItem{
    String mapItemTitle
    String hoover
    Map map
    MediaItem mediaItem

    static hasMany = [mapAreas: MapArea, mapItemGroups: MapItemGroup]
    static belongsTo = [MapArea, MapItemGroup, Map]
    static constraints = {
        mediaItem(nullable: true)
    }
    static mapping = {
        mediaItem cascade: 'save-update'
//        mapItemGroups cascade: 'save-update'
        mediaItem lazy: false
    }


    @Override
    public java.lang.String toString() {
        return mapItemTitle
    }
}
