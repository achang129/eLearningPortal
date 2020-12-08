<template>
  <div class="homework-list">
      <h1>Your Upcoming Assignments: </h1>
      <course-homework/>
  </div>
</template>

<script>

import CourseHomework from '../components/CourseHomework.vue'

export default {
  components: { CourseHomework },
    name: "homework-list",
    component: {
        CourseHomework
    }
}
</script>

<style>

</style>