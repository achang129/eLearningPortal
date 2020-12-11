<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="edit-course" v-else>
      <h1>Edit Course</h1>
      <update-course-form v-bind:courseId="parseInt($route.params.id)" />
    </div>
</template>

<script>
import UpdateCourseForm from '../components/UpdateCourseForm.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "edit-course",
  components: {
    UpdateCourseForm,
    LoadingScreen
  },
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      this.isLoading = false
    }
};
</script>