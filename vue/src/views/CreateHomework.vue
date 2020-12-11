<template>
  <loading-screen v-if="isLoading"></loading-screen>
    <div v-else>
      <router-link to="/homework">Back to Homework</router-link>&nbsp;
      <h1>Add New Homework</h1>
      <create-homework v-bind:courseId="parseInt(this.$route.params.courseId)" />
    </div>
</template>

<script>
import CreateHomework from '../components/CreateHomework.vue';
import LoadingScreen from '../components/LoadingScreen.vue';

export default {
  name: 'add-homework',
  components: {
    CreateHomework,
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