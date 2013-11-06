package curriculum

import org.apache.commons.lang.RandomStringUtils
import org.springframework.dao.DataIntegrityViolationException

class MediaFileController {

    static allowedMethods = [save: "POST", update: "POST"]

    def webRootDir
    def mediaDirVideos
    def mediaDirImages
    def mediaDirSounds
    def mediaDirDocuments

    def acceptableVideos
    def acceptableImages
    def acceptableSounds
    def acceptableDocuments

    def maxSize

    def questionId

    MediaFileController() {
        init()
    }

    def init() {
        maxSize = Integer.parseInt(grailsApplication.metadata['mediaMaxUploadSize'])
        webRootDir = servletContext.getRealPath("/")
        mediaDirVideos = new File(webRootDir, "/media/videos")
        mediaDirImages = new File(webRootDir, "/media/images")
        mediaDirSounds = new File(webRootDir, "/media/sounds")
        mediaDirDocuments = new File(webRootDir, "/media/documents")
        mediaDirVideos.mkdirs()
        mediaDirImages.mkdirs()
        mediaDirSounds.mkdirs()
        mediaDirDocuments.mkdirs()
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [mediaFileInstanceList: MediaFile.list(params), mediaFileInstanceTotal: MediaFile.count(), acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments]
    }

    def create() {
        if (params?.questionId) {
            questionId = params?.questionId
        }
        if (params?.mediaItemId) {
            def mediaFileInstance = new MediaFile(params)
            mediaFileInstance.setMediaItem(MediaItem.get(Long.parseLong(params.mediaItemId)))
            [mediaFileInstance: mediaFileInstance, questionId: questionId]
        }
    }

    def save() {
        def mediaFileInstance = new MediaFile(params)
        if (params?.questionId) {
            questionId = params?.questionId
        }
        MediaItem mediaItem = MediaItem.get(Long.parseLong(params.mediaItemId))
        mediaFileInstance.setMediaItem(mediaItem)
        setUploadableFiles(mediaFileInstance.getMediaItem().getMediaType())

        def file = request.getFile('upload')

        if (file?.getSize() > maxSize) {
            flash.message = message(code: 'media.upload.tooLarge', default: "Túl nagy file! A limit ${(maxSize / 1024) / 1024} Mb.")
            render(view: "create", model: [mediaFileInstance: mediaFileInstance, questionId: questionId])
            return
        }

        //persist file to hdd, and then save the path and extension to the mediaFileInstance entity
        def fileParams = uploadFile(file)

        if (fileParams.equals("notSupported")) {
            flash.message = message(code: 'media.upload.notSupported', default: "Nem megfelelő fájl formátum! Lehetséges formátumok: ${(acceptableVideos.size() > 0) ? acceptableVideos: ""} ${(acceptableDocuments.size > 0) ? acceptableDocuments: ""} ${(acceptableSounds.size > 0) ? acceptableSounds: ""} ${(acceptableImages.size > 0) ? acceptableImages : ""}")
            render(view: "create", model: [mediaFileInstance: mediaFileInstance, questionId: questionId])
            return
        }

        if (fileParams) {
            mediaFileInstance.path = fileParams[0]
            mediaFileInstance.extension = fileParams[1]
        }

        def hasFinalMediaFile = false

        mediaItem.mediaFiles.each() {
            if (it.finalVersion) {
                hasFinalMediaFile = true
            }
        }

        if (mediaFileInstance.finalVersion && hasFinalMediaFile) {
            flash.message = message(code: 'media.upload.finalVersionAlreadyExists', default: "Már létezik végső verzió, egyszerre csak egy média elem lehet végleges!")
            render(view: "create", model: [mediaFileInstance: mediaFileInstance, questionId: questionId])
            return
        }

        if (!mediaFileInstance.save(flush: true)) {
            render(view: "create", model: [mediaFileInstance: mediaFileInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), mediaFileInstance.id])
        redirect(controller: "mediaItem", action: "edit", params: [id: mediaFileInstance.mediaItem.id, questionId: questionId])
    }

    def show(Long id) {
        if (params?.questionId) {
            questionId = params?.questionId
        }
        def mediaFileInstance = MediaFile.get(id)
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(action: "list")
            return
        }

        [mediaFileInstance: mediaFileInstance, questionId: questionId]
    }

    def edit(Long id) {
        if (params?.questionId) {
            questionId = params?.questionId
        }
        def mediaFileInstance = MediaFile.get(id)
        setUploadableFiles(mediaFileInstance.getMediaItem().getMediaType())
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(action: "list")
            return
        }

        [mediaFileInstance: mediaFileInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId]
    }

    def update(Long id, Long version) {
        def mediaFileInstance = MediaFile.get(id)
        MediaItem mediaItem = MediaItem.get(Long.parseLong(params.mediaItemId))
        setUploadableFiles(mediaFileInstance.getMediaItem().getMediaType())
        if (params?.questionId) {
            questionId = params?.questionId
        }
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediaFileInstance.version > version) {
                mediaFileInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'mediaFile.label', default: 'Média  fájl - ')] as Object[],
                        " - Egy másik felhasználó módosította a média fájl adatait, amíg Ön szerkesztette!")
                render(view: "edit", model: [mediaFileInstance: mediaFileInstance, questionId: questionId])
                return
            }
        }

        ////////////////
        // Validation //
        ////////////////

        def hasFinalMediaFile = false

        mediaItem.mediaFiles.each() {
            if (it?.finalVersion && (it != mediaFileInstance)) {
                hasFinalMediaFile = true
            }
        }

        if (params.finalVersion && hasFinalMediaFile) {
            flash.message = message(code: 'media.upload.finalVersionAlreadyExists', default: "Már létezik végső verzió, egyszerre csak egy média elem lehet végleges!")
            render(view: "edit", model: [mediaFileInstance: mediaFileInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId])
            return
        }

        def file = request.getFile('upload')
        if (file?.getSize() > maxSize) {
            flash.message = message(code: 'media.upload.tooLarge', default: "Túl nagy file! A limit ${(maxSize / 1024) / 1024} Mb.")
            render(view: "edit", model: [mediaFileInstance: mediaFileInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId])
            return
        }

        //persist file to hdd, and then save the path and extension to the mediaFileInstance entity
        def fileParams = uploadFile(file)

        if (fileParams.equals("notSupported")) {
            flash.message = message(code: 'media.upload.notSupported', default: "Nem megfelelő file formátum! Lehetséges formátumok: ${(acceptableVideos.size() > 0) ? acceptableVideos : ""} ${(acceptableDocuments.size > 0) ? acceptableDocuments : ""} ${(acceptableSounds.size > 0) ? acceptableSounds : ""} ${(acceptableImages.size > 0) ? acceptableImages : ""}")
            render(view: "edit", model: [mediaFileInstance: mediaFileInstance, acceptableSounds: acceptableSounds, acceptableVideos: acceptableVideos, acceptableImages: acceptableImages, acceptableDocuments: acceptableDocuments, questionId: questionId])
            return
        }

        /////////////////////
        // Validation ends //
        /////////////////////

        mediaFileInstance.properties = params

        if (fileParams) {
            deleteMedia(mediaFileInstance.path)
            mediaFileInstance.path = fileParams[0]
            mediaFileInstance.extension = fileParams[1]
        }

        if (!mediaFileInstance.save(flush: true)) {
            render(view: "edit", model: [mediaFileInstance: mediaFileInstance, questionId: questionId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), mediaFileInstance.id])
        redirect(controller: "mediaItem", action: "edit", params: [id: mediaFileInstance.mediaItem.id, questionId: questionId])
    }

    def delete(Long id) {
        if (params?.questionId) {
            questionId = params?.questionId
        }
        def mediaFileInstance = MediaFile.get(id)
        def mediaItemInstance = mediaFileInstance.mediaItem
        if (!mediaFileInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(controller: "question", action: "edit", id: questionId)
            return
        }

        try {
            deleteMedia(mediaFileInstance.path)
            mediaFileInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(controller: "mediaItem", action: "edit", params: [id: mediaItemInstance.id, questionId: questionId])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'mediaFile.label', default: 'Média  fájl'), id])
            redirect(controller: "mediaItem", action: "edit", params: [id: mediaItemInstance.id, questionId: questionId])
        }
    }

    def setUploadableFiles(mediaType) {
        acceptableVideos = []
        acceptableImages = []
        acceptableSounds = []
        acceptableDocuments = []
        switch (mediaType) {
            case MediaType.VIDEO:
                acceptableVideos = grailsApplication.metadata['mediaAllowedVideoFormats'].tokenize(',[]')
                break
            case MediaType.HANG:
                acceptableSounds = grailsApplication.metadata['mediaAllowedAudioFormats'].tokenize(',[]')
                break
            case MediaType.KEP:
                acceptableImages = grailsApplication.metadata['mediaAllowedImageFormats'].tokenize(',[]')
                break
            case MediaType.DOKUMENTUM:
                acceptableDocuments = grailsApplication.metadata['mediaAllowedDocumentFormats'].tokenize(',[]')
                break
        }
    }

    /**
     * This method handles the file upload process
     * @param file The file, that will be uploaded
     * @return
     */
    def uploadFile(file) {

        if (file.empty) {
            return null
        }

        def extension
        def fileName = file.fileItem.fileName
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i + 1);
        }

        switch (extension) {
            case acceptableImages:
                return generateFile(extension, file, mediaDirImages)
            case acceptableVideos:
                return generateFile(extension, file, mediaDirVideos)
            case acceptableSounds:
                return generateFile(extension, file, mediaDirSounds)
            case acceptableDocuments:
                return generateFile(extension, file, mediaDirDocuments)
            default:
                return "notSupported"
                break
        }
    }

    /**
     * Creates the file on the disk with generated name
     * @param extension The extension of the file
     * @param file The file, that will be saved
     * @param mediaDir The target directory, where the file will be saved
     * @return
     */
    def generateFile(extension, file, mediaDir) {

        def mediaFolder = mediaDir.toString().substring(webRootDir.length())
        mediaFolder = mediaFolder.replace("\\", "/")

        String charset = (('A'..'Z') + ('0'..'9')).join()
        Integer length = 9
        String randomName = RandomStringUtils.random(length, charset.toCharArray())
        def newFile = new File(mediaDir, "${randomName}.${extension}")

        while (newFile.exists()) {
            randomName = RandomStringUtils.random(length, charset.toCharArray())
            newFile = new File(mediaDir, "${randomName}.${extension}")
        }

        file.transferTo(newFile)
        [createLinkTo(dir: mediaFolder, file: "${ randomName }.${ extension }", absolute: true), extension]
    }

    /**
     * Delete the uploaded file from the disk
     * @param url The url of the file
     * @return
     */
    def deleteMedia(String url) {
        def file = url.substring(url.lastIndexOf('/') + 1);
        def extension = url.substring(url.lastIndexOf('.') + 1);

        switch (extension) {
            case acceptableImages:
                new File(mediaDirImages, file).delete()
                break
            case acceptableVideos:
                new File(mediaDirVideos, file).delete()
                break
            case acceptableSounds:
                new File(mediaDirSounds, file).delete()
                break
            case acceptableDocuments:
                new File(mediaDirDocuments, file).delete()
                break
            default:
                break
        }
    }
}
