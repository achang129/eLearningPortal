<template>
  <div>
    <h1>Edit Course</h1>
    <update-course v-bind:courseId="parseInt($route.params.id)" />
  </div>
</template>

<script>
import UpdateCourse from '../components/UpdateCourse.vue';

export default {
  components: {
    UpdateCourse
  }
};
</script>