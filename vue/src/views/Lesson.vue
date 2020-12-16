<template>
  <div class="lesson">
      <router-link
          :to="{name: 'course', params: {id: this.courseid}}">
          <span>Go Back to Course Page</span>
        </router-link>
      <h1></h1>
      <div>
        {{this.lesson}}
      </div>
  </div>
</template>

<script>
export default {
    name: "lesson",
    props: ["courselesson"],
    data() {
      return {
        lesson: this.$store.state.currentLesson,
        courseid: this.$route.params.id
      }
    }
}
</script>

<style>

</style>