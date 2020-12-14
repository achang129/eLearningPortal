<template>
    <div>
        <div>
            <label>Title:</label>
            <textarea v-model="assignment.title" label="Title" cols="30"></textarea>
        </div>
        <div>
            <label>Description:</label>
            <textarea v-model="assignment.description" label="Description" cols="30" rows="10" style="display: flex"></textarea>
        </div>
    </div>
</template>

<script>
  export default {
    name: "assignment-info",
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
    },
    created() {
      this.$store.commit('BLANK_ASSIGNMENT');
    }
  }
</script>