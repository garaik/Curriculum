/**
 * Created with IntelliJ IDEA.
 * User: DullB
 * Date: 2013.10.19.
 * Time: 11:42
 * To change this template use File | Settings | File Templates.
 */
var oneToManyScripts = new Object();

oneToManyScripts.ajaxPost = function(formId, handleAs, responseFunction){
    if (!handleAs){
        handleAs = "text"
    }
    if (!responseFunction){
        responseFunction = function(data){}
    }
    dojo.xhrPost({
        form: formId,
        handleAs: handleAs,
        load: function(data){
            responseFunction(data)
        },
        error: function(error){
                alert("An unexpected error occurred: " + error);
            }
    });
}

oneToManyScripts.ajaxPostReplace = function(formId, elementId, actionLink){
    dojo.require("dojox.html._base"); // eval response data
    var elementId = elementId;
    var form = dojo.byId(formId);
    var orgActionLink = dojo.attr(form, "action");
    if (actionLink){
        dojo.attr(form, "action", actionLink);
    }
    oneToManyScripts.ajaxPost(formId, null, function(data){
        var node = dojo.byId(elementId)
        dojox.html.set(node, data, {
             executeScripts: true
        });
        // reset actionLink
        if (actionLink){
            dojo.attr(form, "action", orgActionLink);
        }
    })
}