package curriculum
/**
 * <p>Creates test data for development.</p>
 * <p>Created by <a href="mailto:krisztian.garai@arvato-systems.hu">Krisztián Garai</a>.
 * <br/>Date: 2013.07.15.</p>
 */
class DevDataCreator {

/*
    private static def log = LoggerFactory.getLogger(this)

    private static def userNames = [
        "2hotLucSra",
        "Burketteral",
        "Cesimamar",
        "ClownLukeSizzlin",
        "Comfyffereq",
        "CuriousHott",
        "FreshWiz",
        "GeneralComfy",
        "GrinderTarget",
        "GuantoLaxr",
        "InsightChiari",
        "InvaderJo",
        "Iserelfr",
        "JavaManiak",
        "LastingWwjd",
        "Lawyetton",
        "MindBradelSummary",
        "MovieApenguin",
        "NeoAlpha",
        "PhiaDrama",
        "PlayFlashy",
        "ReeMama",
        "ScarySoft",
        "Sitivaso",
        "SmartIzHipur",
        "SomberFootball",
        "StrongEat",
        "Surrealerma",
        "TrendyCetic",
        "ValuedPatty",
        "ValuedWet",
        "VultureBig",
        "WhiteDreamy",
        "WsReports",
        "WsVintage",
    ]

    static create() {
        log.debug("----BEFORE----")

        def g1 = new Grade(name: "I. évfolyam").save()
        def g2 = new Grade(name: "II. évfolyam").save()
        def g3 = new Grade(name: "III. évfolyam").save()
        def g4 = new Grade(name: "IV. évfolyam").save()
        def o1 = new Grade(name: "1. osztály").save()
        def o2 = new Grade(name: "2. osztály").save()
        def o3 = new Grade(name: "3. osztály").save()
        def o4 = new Grade(name: "4. osztály").save()
        def o5 = new Grade(name: "5. osztály").save()

        Activity act1 = new Activity(name : "Egyéb tevékenységek", subactivities : new ArrayList<Subactivity>()).save()
        act1.addToSubactivities(name : "Zehernyemetélés")
        act1.addToSubactivities(name : "Zabhegyezés")
        act1.addToSubactivities(name : "Téblábolás")

        Activity act2 = new Activity(name : "Programozás",subactivities : new ArrayList<Subactivity>()).save()
        act2.addToSubactivities(name : "Specifikálás")
        act2.addToSubactivities(name : "Implementálás")
        act2.addToSubactivities(name : "Tesztelés")
        act2.addToSubactivities(name : "Telepítés")

        Activity act3 = new Activity(name : "Testnevelés", subactivities : new ArrayList<Subactivity>()).save()
        act3.addToSubactivities(name : "Erősítés")
        act3.addToSubactivities(name : "Gimnasztika")
        act3.addToSubactivities(name : "Atlétika")
        act3.addToSubactivities(name : "Úszás")

        Activity act4 = new Activity(name : "Olvasás, az írott szöveg megértése", subactivities : new ArrayList<Subactivity>()).save()
        Activity act5 = new Activity(name : "Beszédkészség, szóbeli szövegek megértése, értelmezése és alkotása", subactivities : new ArrayList<Subactivity>()).save();
        Subactivity sact51 = new Subactivity(name: "Színjátszó képesség")
        act5.addToSubactivities(sact51)

        new Capability(name : "Beszédkészség").save()
        new Capability(name : "Írástudás").save()
        new Capability(name : "Artikuláció").save()
        new Capability(name : "Álomfejtés").save()
        new Capability(name : "Jövendőmondás").save()

        new Difficulty(name: "Triviális").save()
        new Difficulty(name: "Egyszerű").save()
        new Difficulty(name: "Könnyű").save()
        def d4 = new Difficulty(name: "Közepes").save()
        new Difficulty(name: "Átlagosnál nehezebb").save()
        new Difficulty(name: "Nehéz").save()
        new Difficulty(name: "Nagyon nehéz").save()
        new Difficulty(name: "Szinte megoldhatatlan").save()
        new Difficulty(name: "Lehetetlennel határos").save()
       def gd1 = new GradeDetails(grade: g1, difficulty: d4, duration: 10).save()


//        new Exercise(
//                gradeDetails: gd1,
//                activity: act1,
//                title: "Lorem ipsum").save(failOnError: true)

        def admin = new User(login: "admin", name: "Adminisztrátor", password: "admin", email: "admin@curriculum.hu", active: true).save()
        for (userName in userNames) {
            new User(
                login: userName,
                name:  createRealNameFromUserName(userName),
                email: userName.toLowerCase() + "@curriculum.hu",
                password: userName,
                active:  true
            ).save()
        }

        log.debug("----AFTER----")
    }

    private static def createRealNameFromUserName(String userName) {
        userName.collect({ it in 'A'..'Z' ? " " + it : it }).join("")
    }
*/
}



