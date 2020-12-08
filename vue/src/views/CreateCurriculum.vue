<template>
  <div class="create-curriculum">
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