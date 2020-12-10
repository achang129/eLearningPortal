<template>
  <div class="create-course">
    <router-link to="/course">Back to Courses</router-link>&nbsp;|&nbsp;
    <h1>Add New Course</h1>
    <create-course />
  </div>
</template>

<script>
import CreateCourse from '../components/CreateCourse.vue';

export default {
  name: "create-curriculum",
  components: {
    CreateCourse
  }
};
</script>