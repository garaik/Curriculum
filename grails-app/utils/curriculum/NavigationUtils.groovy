package curriculum

import javax.servlet.http.HttpSession

/**
 * @author DullB
 * @version 1.0
 * @since 09 11 2013
 */
class NavigationUtils {

    static void addControllerToNavigationList(def session, ControllerNavigation actualPosition, boolean isCreated) {
        if (!session.getAttribute("navigationList")) {
            List<ControllerNavigation> navigationList = new ArrayList<ControllerNavigation>();
            session.setAttribute("navigationList", navigationList)
        }
        if (session.getAttribute("navigationList").isEmpty() || !actualPosition.equals(session.getAttribute("navigationList").last())) {
            session.getAttribute("navigationList").add(actualPosition)
        }
        session.setAttribute("breadCrumbs",getBreadCrumbs(session.getAttribute("navigationList"), isCreated))
    }

    static void initialControllerToNavigationList(def session, ControllerNavigation actualPosition) {

        List<ControllerNavigation> navigationList = new ArrayList<ControllerNavigation>();
        session.setAttribute("navigationList", navigationList)

        if (session.getAttribute("navigationList").isEmpty() || !actualPosition.equals(session.getAttribute("navigationList").last())) {
            session.getAttribute("navigationList").add(actualPosition)
        }
        session.setAttribute("breadCrumbs",getBreadCrumbs(session.getAttribute("navigationList"), false))
    }

    static java.util.Map returnPositionFromControllerNavigationList(def session, ControllerNavigation actualPosition) {
        ArrayList sessionNavigationList = (ArrayList) session.getAttribute("navigationList")
        java.util.Map returnMap
        if (sessionNavigationList && !sessionNavigationList.empty) {
            returnMap = new HashMap();

            removeUnusedLostItem(sessionNavigationList)
            if(actualPosition){
                removeActualPosition(sessionNavigationList, actualPosition)
            }
            returnMap.put('controller', ((ControllerNavigation) sessionNavigationList?.last())?.getController());
            returnMap.put('action', ((ControllerNavigation) sessionNavigationList?.last())?.getAction());
            returnMap.put('id', ((ControllerNavigation) sessionNavigationList?.last())?.getId());

        }
        sessionNavigationList.remove(sessionNavigationList.last())
        session.setAttribute("navigationList",sessionNavigationList)
        return returnMap
    }

    static String getBreadCrumbs( ArrayList sessionNavigationList, boolean isCreated) {
        String breadCrumbs = ""
        def listSize = sessionNavigationList.size()
        int counter = 1
        for (ControllerNavigation navigationItem in sessionNavigationList) {

            if (counter != listSize || (counter == listSize && !isCreated)) {
                breadCrumbs += navigationItem.getBreadCrumbsText()
                breadCrumbs += " >>> "
            }
//            if (counter != listSize && (counter == --listSize && !isCreated )) {}
            counter++
        }
        breadCrumbs
    }

    static java.util.Map getReturnController(def session, ControllerNavigation actualPosition){
        ArrayList sessionNavigationList = new ArrayList()
        sessionNavigationList.addAll(session.getAttribute("navigationList"))
        java.util.Map returnMap
        if (sessionNavigationList && !sessionNavigationList.empty) {
            returnMap = new HashMap();

            removeUnusedLostItem(sessionNavigationList)
            if(actualPosition){
                removeActualPosition(sessionNavigationList, actualPosition)
            }
            returnMap.put('controller', ((ControllerNavigation) sessionNavigationList?.last())?.getController());
            returnMap.put('action', ((ControllerNavigation) sessionNavigationList?.last())?.getAction());
            returnMap.put('id', ((ControllerNavigation) sessionNavigationList?.last())?.getId());

        }
        return returnMap
    }

    private static ArrayList removeUnusedLostItem(ArrayList sessionNavigationList){
        if(sessionNavigationList.size() >= 2 && isTheLastSameAsBeforeTheLast(sessionNavigationList) ){
            sessionNavigationList.remove(sessionNavigationList.last())
        }
    }

    private static boolean isTheLastSameAsBeforeTheLast(ArrayList sessionNavigationList){
        sessionNavigationList.last().equals(sessionNavigationList.get(sessionNavigationList.size()-2))
    }

    private static void removeActualPosition(ArrayList sessionNavigationList, ControllerNavigation actualPosition){
        if(!sessionNavigationList.isEmpty() && sessionNavigationList.last().equals(actualPosition) ){
                    sessionNavigationList.remove(sessionNavigationList.last())
        }
    }
}
