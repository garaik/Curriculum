import curriculum.DevDataCreator
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->
        switch (Environment.current) {
            case Environment.DEVELOPMENT:
                DevDataCreator.create()
                break;
        }
    }

    def destroy = {
    }
}
