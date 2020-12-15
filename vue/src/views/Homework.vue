<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div class="homework" v-else>
      <course-homework v-bind:courseid="parseInt($route.params.id)" />
    </div>
</template>

<script>
import CourseHomework from "@/components/CourseHomework.vue";
import LoadingScreen from '../components/LoadingScreen.vue';
export default {
  name: "Homework",
  props: ["username"],
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
      //this may help us add a back end function to find somebodys relevant homework
      this.props.username = this.$store.state.user.username;
    }
};
</script>

<style>

</style>