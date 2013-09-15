package curriculum

import junit.framework.TestCase

/**
 * Created with IntelliJ IDEA.
 * User: garaik
 * Date: 8/25/13
 * Time: 8:01 PM
 * To change this template use File | Settings | File Templates.
 */
class FilterQueryTest extends TestCase {

    void testIt() {
        String query = "Name:Smith Sex:female age:23..30 login:neo active:igen"
        def m = [:]
        query.split(" ").each({
            it.split(":").with({
                m[it[0].toLowerCase()] = it[1].toLowerCase()
            })
        })
        println m
        def f = [:]
        User.declaredFields.each({
            f[it.name.toLowerCase()] = it
        })
        m.each({name, value ->
            if (f[name]) {
                println f[name].type
            }
        })

    }
}
