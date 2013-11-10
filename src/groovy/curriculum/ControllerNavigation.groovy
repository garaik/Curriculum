package curriculum
/**
 * @author DullB
 * @version 1.0
 * @since 09 11 2013
 */
class ControllerNavigation {

    String controller
    String action
    Long id
    String breadCrumbsText


    @Override
    boolean equals(ControllerNavigation controllerNavigation) {
        if (controllerNavigation.controller?.equals(this.controller) &&
                controllerNavigation.action?.equals(this.action) && controllerNavigation.id == this.id) {
            return true
        }
        return false
    }
}
