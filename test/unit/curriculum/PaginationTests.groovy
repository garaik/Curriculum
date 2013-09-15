package curriculum

import junit.framework.TestCase

/**
 * Created with IntelliJ IDEA.
 * User: garaik
 * Date: 8/24/13
 * Time: 11:01 AM
 * To change this template use File | Settings | File Templates.
 */
class PaginationTests extends TestCase {

    void testFirst() {
        def p = new Pagination(page: 1)
        assertTrue p.first()
        p = new Pagination(page: 2)
        assertFalse p.first()
    }

    void testPrevious() {
        def p = new Pagination(page: 1)
        assertFalse p.previous()
        p = new Pagination(page: 2)
        assertTrue p.previous()
    }

    void testNext() {
        def p = new Pagination(page : 1)
        assertFalse p.next(20)
        assertTrue p.next(21)
        p = new Pagination(page: 2)
        assertFalse p.next(40)
        assertTrue p.next(41)
    }

    void testLast() {
        def p = new Pagination(page: 1)
        assertTrue p.last(0)
        assertTrue p.last(15)
        assertTrue p.last(20)
        assertFalse p.last(21)
        p = new Pagination(page: 2, max: 30)
        assertTrue p.last(35)
        assertFalse p.last(65)
        p = new Pagination(page: 3, max: 50)
        assertTrue p.last(150)
        assertFalse p.last(151)
    }

    void testConstructor() {
        def params = [max: 20, page: 1, action: "GET"]
        def p = new Pagination(params)
        assertEquals p.max, 20
        assertEquals p.page, 1
    }

    void testPlus() {
        def p = new Pagination(page: 2, max: 10)
        def q = p.properties + [page: 3]
        assertEquals q.max, 10
        assertEquals q.page,  3
    }

    void testlastPage() {
        def p = new Pagination()
        //assertEquals 1, p.lastPage(20)
        assertEquals 2, p.lastPage(21)
        assertEquals 0, p.lastPage(0)
        assertEquals 4, p.lastPage(65)
    }

}

