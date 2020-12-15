<template>
    <div>
        <div>
            <textarea v-model="assignment.title" placeholder="Title" label="Title" cols="30" @input="updateTitle"></textarea>
        </div>
        <div>
            <textarea v-model="assignment.description" placeholder="Description" label="Description" cols="30" rows="10" style="display: flex" @input="updateDescription"></textarea>
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
        updateTitle() {
            this.$store.commit("UPDATE_ASSIGNMENT_TITLE", this.assignment.title)
        },
        updateDescription() {
            this.$store.commit("UPDATE_ASSIGNMENT_DESCRIPTION", this.assignment.description)
        }
    },
    created() {
      this.$store.commit('BLANK_ASSIGNMENT');
    }
  }
</script>