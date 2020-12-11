<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="create-course" v-else>
      <router-link to="/courses">Back to Courses</router-link>&nbsp;
      <h1>Add New Course</h1>
      <create-course/>
    </div>
</template>

<script>
import CreateCourse from '../components/CreateCourse.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "create-curriculum",
  components: {
    CreateCourse,
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