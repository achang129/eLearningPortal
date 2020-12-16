<template>
    <loading-screen v-if="isLoading"></loading-screen>
        <div class="edit-homework" v-else>
            <h1>Edit Homework</h1>
            <update-homework
            v-bind:courseid="parseInt($route.params.courseid)"
            v-bind:homeworkid="parseInt($route.params.homeworkid)"
            />
        </div>
</template>

<script>
import UpdateHomework from '../components/UpdateHomework.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: "edit-homework",
  props: ["courseid", "homeworkid"],
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
      this.isLoading = false
    }
};
</script>