package curriculum

/**
 * @author DullB
 * @version 1.0
 * @since 02 11 2013
 */
class  OneToManyUtils {

    /**
     * Returns a list with elements which can be removed from the referencing entity
     * @param params - the params which include the post parameters
     * @param domainReference - the domain referenced which we named in the _form.gsp
     * @param instanceTemplate - the object to select the referenced objects
     * @param listToRemoveFrom - the list where the deleted/kept/new elements are in
     * @return a list with elements which can be removed from the referencing entity
     */
   static def List elementsToRemoveFromList(params, domainReference, instanceTemplate, listToRemoveFrom) {
        def listParamElement = params["${domainReference}[0]"]
        def removeList = new ArrayList(listToRemoveFrom)
        for (int i = 1; listParamElement != null; i++) {
            def instanceElement = instanceTemplate.get(listParamElement.id);
            removeList.remove(instanceElement)
            listParamElement = params["${domainReference}[${i}]"]
        }
        return removeList
    }
}
