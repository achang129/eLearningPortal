<template>
  <div>
    <div>
      <button v-show="assignment.questions.length < 10" @click="addQuestion"> Add Question </button>
    </div>
    <div>
      <p>Total Points: {{totalPoints}}</p>
      <button @click.prevent="resetAssignment">Cancel</button>
      <button type="submit" @click.prevent="createAssignment">Create</button>
    </div>
  </div>
</template>

<script>
import homeworkService from "../services/HomeworkService";

  export default {
    name: 'create-question',
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
        resetAssignment() {
            this.$store.commit("RESET_ASSIGNMENT")
            this.$router.push('/homework')
        },
        createAssignment() {
            homeworkService.addHomework(this.assignment)
                .then(response => {
                if (response.status === 201) {
                    homeworkService.list().then(response => {
                    this.$store.commit("SET_ASSIGNMENTS", response.data);
                    });
                    this.assignment = {
                        title: '',
                            description: '',
                            questions: [
                                {
                                question: '',
                                points: 10,
                                answers: [
                                    {
                                    answer: '',
                                    isCorrect: false
                                    }
                                ]
                                }
                            ]
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