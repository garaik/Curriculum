package curriculum

/**
 * @author DullB
 * @version 1.0
 * @since 26 10 2013
 */
class PairingExercise extends Exercise{

    static hasOne = [map: Map]
    static mapping = {
        discriminator("Pairing")
        map cascade: 'all-delete-orphan'
        map lazy: false
    }
    static constraints = {
        map(nullable: true)
    }
}
