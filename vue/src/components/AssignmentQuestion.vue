<template>
  <div>
        <div v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h1 slot="header">{{item.question}}</h1>
            <div>
                <div>
                    <textarea label="Question" :value="item.question"></textarea>
                    <textarea type="number" label="Points" :value="item.points"></textarea>
                </div>
                <div v-for="(answer, answerIndex) in item.answers" :key="answerIndex">
                    <textarea label="Answer" :value="answer.answer"></textarea>
                    <button @click="removeAnswer({question, answer})">Remove</button>
                </div>
                <div>
                    <button v-if="item.answers.length < 5" @click="addAnswer(question)">Add Answer</button>
                    <button @click="removeQuestion(question)">Remove Question</button>
                </div>
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