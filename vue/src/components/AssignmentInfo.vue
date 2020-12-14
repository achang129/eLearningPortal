<template>
    <div>
        <div>
            <textarea v-model="assignment.title" placeholder="Title" label="Title" cols="30"></textarea>
        </div>
        <div>
            <textarea v-model="assignment.description" placeholder="Description" label="Description" cols="30" rows="10" style="display: flex"></textarea>
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
        
    },
    created() {
      this.$store.commit('BLANK_ASSIGNMENT');
    }
  }
</script>