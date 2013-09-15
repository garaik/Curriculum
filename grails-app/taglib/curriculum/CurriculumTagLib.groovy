package curriculum

import org.springframework.web.servlet.support.RequestContextUtils

import java.text.DateFormat

class CurriculumTagLib {
    static namespace = "app"

    /**
     * Renders the application frame (header, menu, footer, etc.) around the content.
     * @attr title REQUIRED The title of the page.
     */
    def frame = { attrs, body ->
        out << render(template: "/application/before", model: [ title: attrs.title ])
        out << body()
        out << render(template: "/application/after")
    }

    /**
     * Prints the current date in the current locale.
     */
    def now = { attrs, body ->
        def locale = RequestContextUtils.getLocale(request)
        def df = DateFormat.getDateInstance(DateFormat.LONG, locale)
        out << df.format(new Date())
    }
}
