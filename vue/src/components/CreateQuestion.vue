<template>
  <div>
    <div>
      <button v-show="assignment.questions.length < 10" @click="addQuestion"> Add Question </button>
    </div>
    <div>
      <p>Total Points: {{totalPoints}}</p>
      <button to="/homework">Cancel</button>
      <button>Create</button>
    </div>
  </div>
</template>

<script>
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
        addQuestion(){
            this.$store.commit("ADD_QUESTION")
        }
    }
  }
</script>