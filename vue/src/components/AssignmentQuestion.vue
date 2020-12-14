<template>
  <div>
        <div v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h2 slot="header">Question {{questionIndex + 1}}:</h2>
            <form>
                <div>
                    <label>Question Statement:</label>
                    <textarea label="Question" v-model="item.question" @input="updateTitle($event, questionIndex)"></textarea>
                    <label>Points:</label>
                    <textarea type="number" label="Points" v-model.number="item.points" @input="updatePoints($event, questionIndex)"></textarea>
                </div>
                <div v-for="(answer, answerIndex) in item.answers" :key="answerIndex">
                    <label>Answer:</label>
                    <textarea label="Answer" v-model="answer.answer" @input="updateText($event, questionIndex, answerIndex, answer)"></textarea>
                    <label>Correct?</label>
                    <input type="checkbox" v-model="answer.isCorrect" @change="updateState($event, questionIndex, answerIndex)">
                    <button @click.prevent="removeAnswer(questionIndex, answerIndex)">Remove Answer</button>
                </div>
                <div>
                    <button v-if="item.answers.length < 5" @click.prevent="addAnswer(questionIndex)">Add Answer</button>
                    <button @click.prevent="removeQuestion(questionIndex)">Remove Question</button>
                </div>
            </form>
        </div>
  </div>
</template>

<script>
  export default {
    name: 'assignment-questions',
    data() {
        return {
            assignment: this.$store.state.assignment
        }
    },
    methods: {
        addAnswer(question) {
            this.$store.commit("ADD_ANSWER", question)
        },
        removeQuestion(question) {
            this.$store.commit("REMOVE_QUESTION", question)
        },
        removeAnswer(question, answer) {
            this.$store.commit("REMOVE_ANSWER", question, answer)
        },
        updateState(questionIndex, answerIndex) {
            this.$store.commit("UPDATE_ANSWER_STATE", questionIndex, answerIndex)
        },
        updateText(questionIndex, answerIndex, answerText) {
            this.$store.commit("UPDATE_ANSWER_TEXT", questionIndex, answerIndex, answerText)
        },
        updateTitle(questionIndex) {
            this.$store.commit("UPDATE_QUESTION_TITLE", questionIndex)
        },
        updatePoints(questionIndex) {
            this.$store.commit("UPDATE_QUESTION_POINTS", questionIndex)
        }
    }
  }    
</script>