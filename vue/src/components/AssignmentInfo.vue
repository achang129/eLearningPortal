<template>
    <div>
        <h1>{{ assignment.title }}</h1>
        <h2>{{ assignment.description }}</h2>
    </div>
</template>

<script>
  export default {
    name: "assignment-information",
    data() {
        return {
            assignment: this.$store.state.assignment
        }
    },
    methods: {
      updateTitle(value) {
        this.$store.commit("UPDATE_ASSIGNMENT_TITLE", value)
      },
      updateDescription(value) {
        this.$store.commit("UPDATE_ASSIGNMENT_DESC", value)
      }
    }
  }
</script>