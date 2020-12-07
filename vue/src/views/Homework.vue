<template>
  <div class="homework">
    <course-homework v-bind:course-id="parseInt($route.params.id)" />
  </div>
</template>

<script>
import CourseHomework from "@/components/CourseHomework.vue";

export default {
  name: "Homework",
  components: {
    CourseHomework
  }
};
</script>

<style>

</style>