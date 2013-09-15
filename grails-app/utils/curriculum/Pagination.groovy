package curriculum

class Pagination {
    int page = 1
    int max = 20
    String filter
    String order
    int dir = 1

    def propertyMissing(String name, value) {
    }

    def setPage(String v) {
        page = v?v.toInteger():0
    }

    def setMax(String v) {
        max = v?v.toInteger():0
    }

    def setOrder(String v) {
        order = v?v.toInteger():0
    }

    def setDir(String v) {
        dir = v?v.toInteger():0
    }

    boolean first() {
        page == 1
    }

    boolean previous() {
        page > 1
    }

    boolean next(int total) {
        page < total / max
    }

    boolean last(int total) {
        page >= total / max
    }

    int pageFrom() {
        (page - 1) * max + 1
    }

    int pageUntil(int total) {
        Math.min(page * max, total)
    }

    def getListParams() {
        [max: max, offset: (page - 1) * max]
    }

    def getLinkParams() {
        def p = [:]
        if (max != 20) {
            p.max = max
        }
        if (page > 1) {
            p.page = page
        }
        if (filter) {
            p.filter = filter
        }
        if (order) {
            p.order = order
        }
        if (dir != 1) {
            p.dir = dir
        }
        p
    }

    int lastPage(int total) {
        ((int) total / max) + ((total % max) ? 1 : 0)
    }

    @Override
    String toString() {
        "Pagination{" +
        "page=" + page +
        ", max=" + max +
        ", filter='" + filter + '\'' +
        ", order='" + order + '\'' +
        ", dir=" + dir +
        '}'
    }
}
