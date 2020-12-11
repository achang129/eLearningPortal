<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="homework" v-else>
      <course-homework v-bind:course-id="parseInt($route.params.id)" />
    </div>
</template>

<script>
import CourseHomework from "@/components/CourseHomework.vue";
import LoadingScreen from '../components/LoadingScreen.vue';
export default {
  name: "Homework",
  components: {
    CourseHomework,
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

<style>

</style>