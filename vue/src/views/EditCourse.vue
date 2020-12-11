<template>
  <div class="edit-course">
    <h1>Edit Course</h1>
    <update-course-form v-bind:courseId="parseInt($route.params.id)" />
  </div>
</template>

<script>
import UpdateCourseForm from '../components/UpdateCourseForm.vue';

export default {
  name: "edit-course",
  components: {
    UpdateCourseForm
  }
};
</script>