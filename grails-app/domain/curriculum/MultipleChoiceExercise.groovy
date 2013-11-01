package curriculum

/**
 * @author DullB
 * @version 1.0
 * @since 26 10 2013
 */
class MultipleChoiceExercise extends Exercise {

    static hasMany = [questions: Question]
    static mapping = {
        discriminator("MunltipleChoice")
    }

//    @Override
//    public java.lang.String toString() {
//        return super.toString()
//    }
}

