<template>
  <div class="curriculum">
    <h1>Course Details: </h1>
    <course-info v-bind:id="$route.params.id" />
  </div>
</template>

<script>

import CourseInfo from "../components/CourseInfo.vue"

export default {
  name: 'curriculum',
  components: {
    CourseInfo
  }
}
</script>

<style>

</style>