<template>
    <loading-screen v-if="isLoading"></loading-screen>
        <div class="edit-homework" v-else>
            <h1>Edit Homework</h1>
            <update-homework
            v-bind:courseId="parseInt($route.params.courseId)"
            v-bind:homeworkId="parseInt($route.params.homeworkId)"
            />
        </div>
</template>

<script>
import UpdateHomework from '../components/UpdateHomework.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "edit-homework",
  components: {
    UpdateHomework,
    LoadingScreen
  },
  data() {
      return {
        isLoading: true
      }
    },
    mounted () {
      setTimeout(() => {
      this.isLoading = false
    }, 1000)
    }
};
</script>