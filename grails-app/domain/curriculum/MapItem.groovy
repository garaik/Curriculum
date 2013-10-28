package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:35
 * To change this template use File | Settings | File Templates.
 */
class MapItem{
    String description
    String hoover

    static hasMany = [mapAreas: MapArea, mediaItems: MediaItem, mapItemGroups: MapItemGroup]
    static belongsTo = [MapArea, MapItemGroup]

}
