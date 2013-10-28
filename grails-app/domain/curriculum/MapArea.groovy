package curriculum

/**
 * Created with IntelliJ IDEA.
 * User: KovacsV
 * Date: 22/10/13
 * Time: 18:28
 * To change this template use File | Settings | File Templates.
 */
class MapArea {
    Integer xCoordinate
    Integer yCoordinate
    Integer areaWeight
    Integer areaHeight
    Integer areaOrder
    Integer hoover

    static belongsTo = [map: Map]
    static hasMany = [mapItems: MapItem]

}
