<template>
  <div id="assignment">
        <div class="assignment-question" v-for="(item, questionIndex) in assignment.questions" :key="questionIndex" focusable>
            <h2 slot="header">Question {{questionIndex + 1}}:</h2>
            <form>
                <div>
                    <label>Question:</label>
                    <textarea placeholder="Question" label="Question" v-model="item.question"></textarea>
                    <label>Points:</label>
                    <input type="number" label="Points" v-model.number="item.points">
                </div>
                <div v-for="(answer, answerIndex) in item.answers" :key="answerIndex">
                    <label>Answer {{ answerIndex + 1 }}:</label>
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
        <div class="assignment-footer">
            <div>
                <button v-show="assignment.questions.length < 10" @click="addQuestion"> Add Question </button>
            </div>
            <div>
                <p>Total Points: {{totalPoints}}</p>
                <button @click.prevent="resetAssignment">Cancel</button>
                <button type="submit" @click.prevent="createAssignment">Create</button>
            </div>
        </div>
  </div>
</template>

<script>
import homeworkService from "../services/HomeworkService";

  export default {
    name: 'assignment-questions',
    data() {
        return {
            assignment: this.$store.state.assignment
        }
    },
    computed: {
      totalPoints() {
        return this.assignment.questions.reduce((curr, question) =>
          parseInt(question.points) + curr, 0);
      }
    },
    methods: {
        addQuestion() {
            this.$store.commit("ADD_QUESTION")
        },
        addAnswer(question) {
            this.$store.commit("ADD_ANSWER", question)
        },
        removeQuestion(question) {
            this.$store.commit("REMOVE_QUESTION", question)
        },
        removeAnswer(question, answer) {
            let index = {'question':question, 'answer':answer};
            this.$store.commit("REMOVE_ANSWER", index);
        },
        resetAssignment() {
            this.$store.commit("BLANK_ASSIGNMENT")
            this.$router.push('/homework')
        },
        createAssignment() {
            homeworkService.addHomework(this.$store.state.assignment)
            .then(response => {
                if (response.status === 201) {
                    homeworkService.list().then(response => {
                    this.$store.commit("SET_ASSIGNMENTS", response.data);
                    });
                    this.assignment = {
                        name: '',
                            questions: [{
                                question: '',
                                points: 10,
                                answers: [{
                                    answer: '',
                                    isCorrect: false
                                }]
                            }]
                    }
                    this.$router.push('/homework');
                }
            }).catch(error => {
            this.errorMsg = error.response.statusText;
            });
        }
    }
  }    
</script>