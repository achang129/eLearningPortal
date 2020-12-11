<template>
  <div class="edit-homework">
    <h1>Edit Homework</h1>
    <update-homework
      v-bind:courseId="parseInt($route.params.courseId)"
      v-bind:homeworkId="parseInt($route.params.homeworkId)"
    />
  </div>
</template>

<script>
import UpdateHomework from '../components/UpdateHomework.vue';

export default {
  name: "edit-homework",
  components: {
    UpdateHomework
  }
};
</script>