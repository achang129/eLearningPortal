<template>
  <div id="assignment-question">
        <div v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h2 slot="header">Question {{questionIndex + 1}}:</h2>
            <form>
                <div>
                    <textarea placeholder="Question" label="Question" v-model="item.question"></textarea>
                    <label>Points:</label>
                    <input type="number" label="Points" v-model.number="item.points">
                </div>
                <div v-for="(answer, answerIndex) in item.answers" :key="answerIndex">
                    <textarea placeholder="Answer" label="Answer" v-model="answer.answer"></textarea>
                    <label>Correct?</label>
                    <input type="checkbox" v-model="answer.isCorrect">
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
            let index = {'question':question, 'answer':answer};
            this.$store.commit("REMOVE_ANSWER", index);
        }
    }
  }    
</script>