package curriculum



import org.junit.*
import grails.test.mixin.*

@TestFor(GradeDetailsController)
@Mock(GradeDetails)
class GradeDetailsControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/gradeDetails/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.gradeDetailsInstanceList.size() == 0
        assert model.gradeDetailsInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.gradeDetailsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.gradeDetailsInstance != null
        assert view == '/gradeDetails/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/gradeDetails/show/1'
        assert controller.flash.message != null
        assert GradeDetails.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/gradeDetails/list'

        populateValidParams(params)
        def gradeDetails = new GradeDetails(params)

        assert gradeDetails.save() != null

        params.id = gradeDetails.id

        def model = controller.show()

        assert model.gradeDetailsInstance == gradeDetails
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/gradeDetails/list'

        populateValidParams(params)
        def gradeDetails = new GradeDetails(params)

        assert gradeDetails.save() != null

        params.id = gradeDetails.id

        def model = controller.edit()

        assert model.gradeDetailsInstance == gradeDetails
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/gradeDetails/list'

        response.reset()

        populateValidParams(params)
        def gradeDetails = new GradeDetails(params)

        assert gradeDetails.save() != null

        // test invalid parameters in update
        params.id = gradeDetails.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/gradeDetails/edit"
        assert model.gradeDetailsInstance != null

        gradeDetails.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/gradeDetails/show/$gradeDetails.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        gradeDetails.clearErrors()

        populateValidParams(params)
        params.id = gradeDetails.id
        params.version = -1
        controller.update()

        assert view == "/gradeDetails/edit"
        assert model.gradeDetailsInstance != null
        assert model.gradeDetailsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/gradeDetails/list'

        response.reset()

        populateValidParams(params)
        def gradeDetails = new GradeDetails(params)

        assert gradeDetails.save() != null
        assert GradeDetails.count() == 1

        params.id = gradeDetails.id

        controller.delete()

        assert GradeDetails.count() == 0
        assert GradeDetails.get(gradeDetails.id) == null
        assert response.redirectedUrl == '/gradeDetails/list'
    }
}
