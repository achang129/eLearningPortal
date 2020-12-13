<template>
  <div>
        <div v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h1 slot="header">Question {{questionIndex+1}}:</h1>
            <form>
                <div>
                    <label>Question Statement:</label>
                    <textarea label="Question" :value="item.question"></textarea>
                    <label>Points:</label>
                    <textarea type="number" label="Points" :value="item.points"></textarea>
                </div>
                <div v-for="(answer, answerIndex) in item.answers" :key="answerIndex">
                    <label>Answer:</label>
                    <textarea label="Answer" :value="answer.answer"></textarea>
                    <button @click.prevent="removeAnswer(questionIndex, answerIndex)">Remove</button>
                </div>
                <div>
                    <button v-if="item.answers.length < 5" @click.prevent="addAnswer(questionIndex)">Add Answer</button>
                    <button @click.prevent="removeQuestion(questionIndex)">Remove Question</button>
                </div>
            </form>
            <div>
               
            </div>
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
        }
    }
  }    
</script>