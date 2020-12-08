<template>
  <div>
    <router-link to="/homework">Back to Homework</router-link>&nbsp;|&nbsp;
    <h1>Add New Homework</h1>
    <create-homework v-bind:courseId="parseInt(this.$route.params.courseId)" />
  </div>
</template>

<script>
import CreateHomework from '../components/CreateHomework.vue';

export default {
  name: 'add-homework',
  components: {
    CreateHomework
  }
};
</script>